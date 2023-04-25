Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F706EDB50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjDYFpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjDYFpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C75493F6;
        Mon, 24 Apr 2023 22:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEFE862A50;
        Tue, 25 Apr 2023 05:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D25C433EF;
        Tue, 25 Apr 2023 05:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682401513;
        bh=Qgn9h/58uriK3S3euesQ2C9xLjg/ne9xaOmQRCdopA8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Z425/8mB1JcAWHggR511kyQ0rz6faETBhNC35BFw0s3elytPxcX557cJWuqi8sqI2
         h5+U+27FriW2a8yVJMRZJZzdoZOxE96zzsDRPAHFWEe6TsceBmSxodvWEr7ZFsHaqk
         XabKfBZt90aqx20bXSfO+Ptxx5/6qUnOwsLjAdWRLpLoi4FlPzthMK+pbsm0YbILwr
         hrR3Ous5h6jEfQyHiFFDlwWsWLj7zhw2ssa+QJVJJ3SjwCKmqrdU5Z8/OhYMDwC2RB
         8lkV0HJ7PnbVDJWHTl7sf/aH/yD0Tf6BONV2DoXzur6jEQhc9nToJViytQ2p8ZOuWI
         Ovu3V+VSwz8mg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Toke =?utf-8?Q?H=C3=B8iland-J?= =?utf-8?Q?=C3=B8rgensen?= 
        <toke@toke.dk>, linux-kernel@vger.kernel.org,
        syzbot+f2cb6e0ffdb961921e4d@syzkaller.appspotmail.com,
        syzbot+df61b36319e045c00a08@syzkaller.appspotmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: fix races between ath9k_wmi_cmd and ath9k_wmi_ctrl_rx
References: <20230425033832.2041-1-hdanton@sina.com>
Date:   Tue, 25 Apr 2023 08:45:06 +0300
In-Reply-To: <20230425033832.2041-1-hdanton@sina.com> (Hillf Danton's message
        of "Tue, 25 Apr 2023 11:38:32 +0800")
Message-ID: <87edo8qzvh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton <hdanton@sina.com> writes:

> On 24 Apr 2023 22:18:26 +0300 Fedor Pchelkin <pchelkin@ispras.ru>
>> Currently, the synchronization between ath9k_wmi_cmd() and
>> ath9k_wmi_ctrl_rx() is exposed to a race condition which, although being
>> rather unlikely, can lead to invalid behaviour of ath9k_wmi_cmd().
>> 
>> Consider the following scenario:
>> 
>> CPU0					CPU1
>> 
>> ath9k_wmi_cmd(...)
>>   mutex_lock(&wmi->op_mutex)
>>   ath9k_wmi_cmd_issue(...)
>>   wait_for_completion_timeout(...)
>>   ---
>>   timeout
>>   ---
>> 					/* the callback is being processed
>> 					 * before last_seq_id became zero
>> 					 */
>> 					ath9k_wmi_ctrl_rx(...)
>> 					  spin_lock_irqsave(...)
>> 					  /* wmi->last_seq_id check here
>> 					   * doesn't detect timeout yet
>> 					   */
>> 					  spin_unlock_irqrestore(...)
>>   /* last_seq_id is zeroed to
>>    * indicate there was a timeout
>>    */
>>   wmi->last_seq_id = 0
>
> Without	wmi->wmi_lock held, updating last_seq_id on the waiter side
> means it is random on the waker side, so the fix below is incorrect.
>
>>   mutex_unlock(&wmi->op_mutex)
>>   return -ETIMEDOUT
>> 
>> ath9k_wmi_cmd(...)
>>   mutex_lock(&wmi->op_mutex)
>>   /* the buffer is replaced with
>>    * another one
>>    */
>>   wmi->cmd_rsp_buf = rsp_buf
>>   wmi->cmd_rsp_len = rsp_len
>>   ath9k_wmi_cmd_issue(...)
>>     spin_lock_irqsave(...)
>>     spin_unlock_irqrestore(...)
>>   wait_for_completion_timeout(...)
>> 					/* the continuation of the
>> 					 * callback left after the first
>> 					 * ath9k_wmi_cmd call
>> 					 */
>> 					  ath9k_wmi_rsp_callback(...)
>> 					    /* copying data designated
>> 					     * to already timeouted
>> 					     * WMI command into an
>> 					     * inappropriate wmi_cmd_buf
>> 					     */
>> 					    memcpy(...)
>> 					    complete(&wmi->cmd_wait)
>>   /* awakened by the bogus callback
>>    * => invalid return result
>>    */
>>   mutex_unlock(&wmi->op_mutex)
>>   return 0
>> 
>> To fix this, move ath9k_wmi_rsp_callback() under wmi_lock inside
>> ath9k_wmi_ctrl_rx() so that the wmi->cmd_wait can be completed only for
>> initially designated wmi_cmd call, otherwise the path would be rejected
>> with last_seq_id check.
>> 
>> Also move recording the rsp buffer and length into ath9k_wmi_cmd_issue()
>> under the same wmi_lock with last_seq_id update to avoid their racy
>> changes.
>
> Better in a seperate one.

Adding linux-wireless, please always CC the list with wireless patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

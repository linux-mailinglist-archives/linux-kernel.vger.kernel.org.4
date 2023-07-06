Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4374A2ED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjGFROI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjGFROG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:14:06 -0400
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA21BE9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 10:14:03 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id HSYJqKhc3f9upHSYJqznA5; Thu, 06 Jul 2023 19:14:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1688663641;
        bh=56KuZrkMbRd2J7ViCPHtCF/MZvoglrK3t93PpbFw9Sg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NI1Qkk5cFyNMwPvdl5dFpR6F+HQKlxywtwBxcRHHwB8l1PcNTga97/IQEky9Fnf83
         3MNxs7faTlWo9s1BrpxV0+2yduVgzquLEGxgFTayoiAQ8fGQxXPeRDXlPXllD35qpq
         JC8pZ6YyHsuAVG4M7uzmidgbQZ8+slpUSIccgyvqW0ViiJZLIAB2FtatPMbNwEuOJe
         Kvslkuitopvxweh2Qn2q6b+Xk/nLNxFh4C3iv8thkRujedw/XZN24MkrrcjK1YS37A
         MGwl1GnEKDIlgF1Zvth437FFPLY3RVnjL31ARVL954DYE1GgHFswNkY0GDSZizRDHM
         UGBHpjyIOWGyQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Jul 2023 19:14:01 +0200
X-ME-IP: 86.243.2.178
Message-ID: <a409e348-0d15-e7f6-5d97-1ebe8341027a@wanadoo.fr>
Date:   Thu, 6 Jul 2023 19:13:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] net:tipc:Remove repeated initialization
Content-Language: fr, en-US
To:     Wang Ming <machel@vivo.com>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
        Jakub Kicinski <kuba@kernel.org>
References: <20230706134226.9119-1-machel@vivo.com>
 <20230706084729.12ed5725@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230706084729.12ed5725@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 06/07/2023 à 17:47, Jakub Kicinski a écrit :
> On Thu,  6 Jul 2023 21:42:09 +0800 Wang Ming wrote:
>> The original code initializes 'tmp' twice,
>> which causes duplicate initialization issue.
>> To fix this, we remove the second initialization
>> of 'tmp' and use 'parent' directly forsubsequent
>> operations.
>>
>> Signed-off-by: Wang Ming <machel@vivo.com>
> 
> Please stop sending the "remove repeated initialization" patches
> to networking, thanks.
> 
> 

The patch also looks just bogus, as 'parent' is now always NULL when:
    rb_link_node(&m->tree_node, parent, n);

is called after the while loop.

CJ

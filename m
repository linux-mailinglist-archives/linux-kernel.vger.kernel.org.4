Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6D73909B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 22:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjFUUOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 16:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjFUUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 16:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE05199E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 13:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E094616C2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 20:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C9C433C8;
        Wed, 21 Jun 2023 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687378452;
        bh=dCDy3A/rSNHdhp/mXd4huyXQOqZFkZsHTIPIxDQhj1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lbsWLd827a+PxMQHbt38u8IpyWB5Z0MoDwCAqH7tAxr6C8D2NtuYuQ7jWmhUegU0C
         32AXpzlJNA53IP9fqpkriSMSrSnVgZ1h7Bx85DFPLNXyEFBKWWXz+e0g+c9H3RM8Py
         OLr5T1WjcA2ofwM3UmTxVfnFhbjZiXZrkW2+IVnCBhm+otwXbeGqzyMuRAqG6CEGhK
         0/WQFLgOJyMV66NNAC64hLUKF+bz9JaJqA4e/DCf47l88Vaj90fzb/eSsyHo/qz523
         CFBP5/2/cWggjNwYt9LRZ4PIVdbSLnCqtG55uEC9tqd2eXBtQUBcAFFWbUbFjbaoIP
         mbPmVg3jJ3s5w==
Date:   Wed, 21 Jun 2023 13:14:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     syzbot <syzbot+a7d200a347f912723e5c@syzkaller.appspotmail.com>,
        Johannes Berg <johannes@sipsolutions.net>, bpf@vger.kernel.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in netlink_set_err
Message-ID: <20230621131411.6be73cc6@kernel.org>
In-Reply-To: <CANn89i+2Ex=guwKkmuyJUE5gLmnoGSd-8m_V4xmJhCkcUcn=AQ@mail.gmail.com>
References: <000000000000e38d1605fea5747e@google.com>
        <20230621124246.07f9833c@kernel.org>
        <CANn89i+2Ex=guwKkmuyJUE5gLmnoGSd-8m_V4xmJhCkcUcn=AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 22:05:13 +0200 Eric Dumazet wrote:
> > Doesn't seem like netlink_set_err() wants to be called from just any
> > context. Should we convert nl_table_lock to alwasy be _bh ?
> >  
> 
> Jakub I already sent a fix :
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20230621154337.1668594-1-edumazet@google.com/

Ah, I didn't spot it, LG!

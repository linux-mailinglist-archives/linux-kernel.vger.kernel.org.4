Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17843648125
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLIKvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLIKvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:51:35 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8334E326F5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:51:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670583082; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=U5CMJ7vXtiHxe8gnQAdT3haARLAMYfnF3zixV7ddlXZnbZ/VEQz/PcwsPWGZA/0WvdhrkmhSmHgSD9M1Kdk82T/R7r2PUEO+UKCUXgwutX7OtlvIySqB5Ysdx6jGY36RGXYNbA1sjYck99OMQVt7rd3VbQQRz67Si+hnXT5HUTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1670583082; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=n2OIW6Zki7hh9PQlGDE45HtL8GBarX6yLnXDU1h5u3g=; 
        b=YB7jcr/i+pxfCyYsD8io2t1p86RbwrjguY9BTtCTZmB3nPD4Oj/dWOFGQD8t6qdWaROfAVisq35cOzLuvO0UQjmqr1JBfIEEPxR8y6yzxLZQ/d5YVFhkA0N0R3K6aCPB26B63GAAC5xK7nX0hRdxTEr2xokXvWMnxOHp63TVSss=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670583082;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=n2OIW6Zki7hh9PQlGDE45HtL8GBarX6yLnXDU1h5u3g=;
        b=TpsbXgPHROlcGN79JcKP8KAYVhOgMipzrZmb1RJUmrxQ7T2hCh+f5pRLXn/7PFQv
        IIYMHT1CYAjUs57ZQbnfTXp3a8YVDeVbkDF450R4j979Om80/gbdpdWuLaw9uXgDRyP
        fQpV9tojrTpi+b1x3sf7ipjlvqNVQOyMIcs240to=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1670583081876813.6343775119691; Fri, 9 Dec 2022 16:21:21 +0530 (IST)
Message-ID: <524d919d-0197-2a81-9165-d0d6feb607fe@siddh.me>
Date:   Fri, 9 Dec 2022 16:21:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     syzbot+6f7fe2dbc479dca0ed17@syzkaller.appspotmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000cad06305d2ea0750@google.com>
Subject: Re: [syzbot] WARNING in drm_wait_one_vblank
Content-Language: en-US, en-GB, hi-IN
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <000000000000cad06305d2ea0750@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test the reproducer on latest.

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

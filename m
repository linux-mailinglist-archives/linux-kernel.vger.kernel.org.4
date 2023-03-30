Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD736D0896
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjC3Op2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjC3Op0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:45:26 -0400
Received: from forward500b.mail.yandex.net (forward500b.mail.yandex.net [178.154.239.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F98691
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:45:21 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:4a05:0:640:40c8:0])
        by forward500b.mail.yandex.net (Yandex) with ESMTP id A12DB5F188;
        Thu, 30 Mar 2023 17:45:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id FjKuDP2Wsa60-57BudbbW;
        Thu, 30 Mar 2023 17:45:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680187517;
        bh=VO0en26O8PrSdBFVkwG8Ovp3sfiCyZcbgKZ05t43wVo=;
        h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
        b=O/7CKkWaZyOy3O41HRO8zV/wpVY3aZIpsOKGpwMZGKsuSAkXXcqUEudtVGNKe94/m
         a9YJnF3pBF0u+pfblVjgQ3P4jLBNDlFDAOn9anDWCJILCaQhIluyFdvAirZB46bhjQ
         lG+BmmXUYEoj3OAFLukyIz6yzC6A+sPaiwTUV2cU=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <38c80313-ba1c-092c-ae31-f58fe6ffa82c@yandex.ru>
Date:   Thu, 30 Mar 2023 19:45:14 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: MREMAP_DONTUNMAP corrupts initial mapping
Content-Language: en-US
From:   stsp <stsp2@yandex.ru>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <aee53ac3-6d25-5009-7416-3f7c5fe1f989@yandex.ru>
In-Reply-To: <aee53ac3-6d25-5009-7416-3f7c5fe1f989@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few CCs.

30.03.2023 17:38, stsp пишет:
> Hello.
>
> Attached is a small test-case that
> demonstrates the problem.
> The problem happens if you change
> some data in a file-backed private
> mapping and then use mremap on
> it with MREMAP_DONTUNMAP flag.
> The result is:
> - destination copy is valid
> - source copy restored from the original file
>
> So the 2 copies do not match.

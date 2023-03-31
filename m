Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190F6D182A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjCaHJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCaHJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:09:29 -0400
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 31 Mar 2023 00:09:12 PDT
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D71A479;
        Fri, 31 Mar 2023 00:09:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:4293:0:640:63a5:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 82CA35F2EB;
        Fri, 31 Mar 2023 09:53:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8rD4m6AWmOs0-8GczFjpi;
        Fri, 31 Mar 2023 09:53:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680245591;
        bh=5C86jBDs/6conBmzva1uyHsQQIhuyXRMvmW+gOB/YHU=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=jG0SL9m26Nd+Xe6hrYRqghcMOP8IHaYeUJ5T1vlD9pfT7cr9vJdc7HgYfUFrLN+kS
         TifDr56M48uEMY7+ITQNI7rzx44iHmKBEC/jh8Zfvhten/GmOQ/KYM5wwvzfr/ipFg
         W8z1boMG1gsHsgC5DcBIiSvgpbQPq/XQt/0KgAGU=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <3a3422e5-8cd2-1a13-5eef-425383808396@yandex.ru>
Date:   Fri, 31 Mar 2023 11:53:08 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: MREMAP_DONTUNMAP corrupts initial mapping
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Brian Geffon <bgeffon@google.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <aee53ac3-6d25-5009-7416-3f7c5fe1f989@yandex.ru>
 <38c80313-ba1c-092c-ae31-f58fe6ffa82c@yandex.ru>
 <498d7a19-2b29-46ea-9c34-ec8fb7394e6c@lucifer.local>
From:   stsp <stsp2@yandex.ru>
In-Reply-To: <498d7a19-2b29-46ea-9c34-ec8fb7394e6c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for info.

30.03.2023 23:42, Lorenzo Stoakes пишет:
> This seems to be a case of the documentation not quite being correct in the
> case of a MAP_PRIVATE file mapping, from the mremap man page discussing
> MREMAP_DONTUNMAP:-
Yes, it seems to be the case.
However, current semantic of MREMAP_DONTUNMAP
is unsatisfactory for many uses.
Have you considered adding more flags
to get things consistent?
For my use-case, at the very least 1 more
flag is needed to specify that in case of an
anonymous mapping I need the source
aliased not to zero-page but to destination
mapping, so that the source and dest do
match unless manually modified.
Another similar flag may be needed to
say that in case of a file-backed private
mapping source needs to be converted
to anonymous mapping, and if the first
flag is also specified, then again source
and dest would match. That can be used
in case the private file-backed mapping
was modified by hands.

Overall I need a set of flags that can
guarantee that MREMAP_DONTUNMAP
doesn't change the source data.
Can something like that be considered?

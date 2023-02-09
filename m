Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16DB68FCCE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjBICDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjBICDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:03:38 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4336B25973
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:03:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id f34so1196664lfv.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 18:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wpbhKb6PCWqitcpF+KztK8LkCfUogfjPGXlhCk+nko=;
        b=N8dxlFPY97Zdt08adulRLRKyc1gg6nLtHX6LDy57XcJ12OFfF+zG2uy+XbcIlUPmzO
         ALheyy0jbOtIp3NtWPAGsqfg0YHzs1deQ7ZapNHSPCiuJ3+8o2U2zaGSC+txn+0aT7uj
         JuaYQvcxK3wY6BrrXA0eyiULr8cecRMCPfIRpAOiR5DRnjqbdQE/0w57QwtZkHF6cYau
         vOQk9kIoi1OUXLdFQNFETsm9WVvtbS/EQKuiBa5Wb5EyuNOZYDNks+r4vM7+pxiyRrrz
         xVM+M70s6nYomCA/MlRKaSruQu6msvtgGDtnk2NnqPCjw/x32Ugcfik8eGjO5cAs57FA
         f6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wpbhKb6PCWqitcpF+KztK8LkCfUogfjPGXlhCk+nko=;
        b=CwxNGciAjrNKiiSSRnvOL7KM5rL69ZgiXeKvmeInbLxfkTlwhUnZ7IRro0XeUPbKLr
         94IhWPYfJaps/Aoqj3dtjZYryQfLa2ggWxhjv/6PXISNl14HN/6UTzklhljcDLHhkHlB
         wEMCdWqbT1nH17aK7RCi8xFraflzr4UiDgq34iVGQhDM0tPDMamlxQU/lemw4oB3ynVs
         DzB7kTPlZYCtVV/gkAheCN7lQ0Cgd0ohqTeV4neaTcknOPAYcqcJr2nGWb04dHNX8mzD
         eoXAQ3zJdMmg76hoiROcf8g4EGCk+DKia10+FtDw5IqGr4xe5uxAV3wr8QXSIirRzlsS
         Z75g==
X-Gm-Message-State: AO0yUKVsNQ0a+DXBj3Z3/y+wXNu6bzV75gsLn/9ITd31oSDd5E3NrkGB
        K2jr55zObnhIvQqKiM8ofAUxR8+fzlOwTLrPqnQ=
X-Google-Smtp-Source: AK7set86DF6JSVay1oyAqtnLhmYEG3+tim+RPGMEM718C2gOfldauh6tcUoygjt1ghpYvV92EwgZnXQ6eW7AHYBySE8=
X-Received: by 2002:a19:f60e:0:b0:4b5:5f2d:1458 with SMTP id
 x14-20020a19f60e000000b004b55f2d1458mr1783908lfe.253.1675908188264; Wed, 08
 Feb 2023 18:03:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675851111.git.chenfeiyang@loongson.cn> <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
 <Y+N76C7hfcu5Ze/J@1wt.eu>
In-Reply-To: <Y+N76C7hfcu5Ze/J@1wt.eu>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Thu, 9 Feb 2023 10:02:56 +0800
Message-ID: <CACWXhKmmG799esYaEZZqWwNx-UwL74r6sr0qrxrF=Li4Ehckgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on
 statx() when available
To:     Willy Tarreau <w@1wt.eu>
Cc:     paulmck@kernel.org, Feiyang Chen <chenfeiyang@loongson.cn>,
        arnd@arndb.de, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 at 18:39, Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Feiyang,
>
> On Wed, Feb 08, 2023 at 06:17:51PM +0800, chris.chenfeiyang@gmail.com wrote:
> > From: Feiyang Chen <chenfeiyang@loongson.cn>
> >
> > loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
> > openrisc have statx() and stat64() but not stat() or newstat().
> > Add statx() and make stat() rely on statx() to make them happy.
>
> Thanks for this, that's way better. I'm just having one small request
> below:
>
> > +/*
> > + * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
> > + */
> > +
> > +static __attribute__((unused))
> > +int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> > +{
> > +     return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
> > +}
> > +
> > +static __attribute__((unused))
> > +int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
> > +{
> > +     int ret = sys_statx(fd, path, flags, mask, buf);
> > +
> > +     if (ret < 0) {
> > +             SET_ERRNO(-ret);
> > +             ret = -1;
> > +     }
> > +     return ret;
> > +}
>
> Please guard these inside #if defined(__NR_statx) so that this can still
> be used as-is from slightly older toolchains that provide their own kernel
> includes.
>

Hi, Willy,

OK.

Thanks,
Feiyang

> The rest of the series looks pretty good to me.
>
> Thank you!
> Willy

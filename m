Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BE66AD3C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjANSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 13:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjANSMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:12:30 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73150B77B;
        Sat, 14 Jan 2023 10:12:29 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x40so3324989lfu.12;
        Sat, 14 Jan 2023 10:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tJ4I2+kGQp0jFq18r3oaQbBG/6QGMIIEVSgmjg/A278=;
        b=oIJsRpbpWfMnyX/de9Bi+AJ54jTQbu01aSmy8M0BinUy4WyTKc3JWn540INVhymiei
         mQwuSMIPg6Ulqz+wkw3AidX+ddfn6+GL78EdyW9WwHHmgukIkaHLdjxpaQwhspEZVVK/
         En3rjKfzhyZx1geu1ku1Dz9FTPV8OmTlcK4QJmi06DuhQ7WnLtJwRNKLxoTj1KvELDvu
         osrNncObjMw6e8PyT48aJQKJKcZ3ugT3Lm5TVyg4vJz6+R+iWjW+TJD2tkpSVyVxq2po
         LEiDlI/ui+bvFCpwuFZoJJq1+E3AyQzO7QAqR71u6OwN9wlg3ePgoExTqTSjKMP74k8s
         4WfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJ4I2+kGQp0jFq18r3oaQbBG/6QGMIIEVSgmjg/A278=;
        b=5MaZqlBPVIPDTKLrsKqFimzU5Eev5Zc71RmtoCimyRDhpZJlqXnlqCNQBb0AQlcazu
         o7quUtVYdXgCAbyvTeg+339c+dPhl2GCXCuz13PuypbDW5mkjqqZUAgncJEpLFFyqfnZ
         e5uCes7XsXOMe+8v7N/PbcMaOiDC68Naf3DN4hqlZ6/F9ZeujHJnZIXVEdBUJe2D4dL0
         MMgKFnosZcmV7Y/kLd2Re3EUI0f4VyNW4cN4009E1c0m3+r1GEijO18nQoQlq2iCnvwJ
         4U9SkDOP99LDFjwm2LVU+VrU2rk7ygM8ehd4eRJ1xIhi1TFIMCY1vFPza848pBz8vRVr
         O7Nw==
X-Gm-Message-State: AFqh2krfY7uI7a423mDHnMFILS6ePmBucocMYI42IB8VPFH7Frp8zzhj
        KO22wH0me4FLNmVgmt+iGDhBlLBgODxQNEy64cQIpeBd
X-Google-Smtp-Source: AMrXdXvyH2VlCP28geTu0pnQSHpRJp5HLHtbdEpNMOm7rUlMmDhlBsdso4n9j/SemhctQimd8Rfcd8ey04XyrzykRjw=
X-Received: by 2002:a05:6512:14d:b0:4cb:3a2f:26d1 with SMTP id
 m13-20020a056512014d00b004cb3a2f26d1mr2121991lfo.303.1673719947706; Sat, 14
 Jan 2023 10:12:27 -0800 (PST)
MIME-Version: 1.0
References: <Y7zBtCZ/eRJCpjBf@work> <202301121449.1C2AEFC2E7@keescook>
In-Reply-To: <202301121449.1C2AEFC2E7@keescook>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 14 Jan 2023 12:12:16 -0600
Message-ID: <CAH2r5mt=DLrN2F0wwhPpMicHZsGJF5nQXQk0ptYTJy2a9xWcwA@mail.gmail.com>
Subject: Re: [PATCH][next] cifs: Replace zero-length arrays with
 flexible-array members
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

merged into cifs-2.6.git for-next

On Thu, Jan 12, 2023 at 4:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 09, 2023 at 07:39:00PM -0600, Gustavo A. R. Silva wrote:
> > Zero-length arrays are deprecated[1] and we are moving towards
> > adopting C99 flexible-array members instead. So, replace zero-length
> > arrays in a couple of structures with flex-array members.
> >
> > This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> > routines on memcpy() and help us make progress towards globally
> > enabling -fstrict-flex-arrays=3 [2].
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook



-- 
Thanks,

Steve

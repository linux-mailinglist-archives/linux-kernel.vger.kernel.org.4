Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EFC6F85A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjEEPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjEEPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:25:19 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70D1C0DC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 08:23:47 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so14579391276.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683300216; x=1685892216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/3vTohp91jiKKtxYYXC9sZ4oDT0Wvdf7xVOWIDy7Fk=;
        b=Bszl0DwZbz8s+myurjfDruThE0Fu8MhipC9cyx9FTy3XiZxkMKgFbm867G2C7RFNbT
         OJczRbftk7euoqYCIpgBXpuyjmZnTE8jpjOwFvJJ3s/14zLgxyQjZjhqwtzHVIeb9rHH
         h70UHwRlPMA2MUR8cG2u9TKfm7m10YDCj7ZelEEfzTiSLn15zDrDojwEIkVgmD5VnDSv
         HsR7FB2fKjU/MVKSotN/8UpkcEqIFiaiWiww4pIvKGNGUKhbKawbk1skibuLteTKnxCc
         y4Xn865xcSP3LUMtcRXSqSyY6lp9eAE99FUGbpcL32FJ0gHXsTQpLgKCjmDkPqmv4uJC
         8EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683300216; x=1685892216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/3vTohp91jiKKtxYYXC9sZ4oDT0Wvdf7xVOWIDy7Fk=;
        b=OpN8sLIp0CSCOodg6uAYdUPVrxm08NVGJa7chV7NIydu6mvbe/P/kG/OYjvWXwtIAQ
         JbmoU1bAMkP2NyVyKMhn/xK4uv6PQxCzAWMAANG176CyxaWyV1banNThxX21rua8br5e
         dZHkgltl+HQW7RLG+0duto4DNItDBaXZSbP4/PtentwBrnqCDfgnwhyB+N7tfdod3I0m
         KzxGWwogkTgJ9yCdY1Q6nT3IkZBBGl/Uq02t80qMpVagpPnNDLTqeHuSivqjGc0LaH+K
         p1FSb1uubELw38MGjYCULEBPOAGH2x2jaGgcsAsm7MVP8G/mektSO/kFds5vqZmWhP8l
         NkuA==
X-Gm-Message-State: AC+VfDyfjXPZfzowaU/dxOV4Zy0kwZCBI50R4QpzGgN3q/MKn4yrtS4S
        +z09wAFVhgq+Y2VVfJ9NMWoPGn6w/mpgWjJGRUbp
X-Google-Smtp-Source: ACHHUZ57JDqGgS/uAWi4XXuD+Aw3Brz4iCdRPH0YMiqpZ3PYVd37YzF/qiHvizGQHZkqKkRe+0+w3obMHGqdV1gyjoM=
X-Received: by 2002:a81:138d:0:b0:559:f517:a72d with SMTP id
 135-20020a81138d000000b00559f517a72dmr2939441ywt.14.1683300215767; Fri, 05
 May 2023 08:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230504213002.56803-1-michael.mccracken@gmail.com>
 <fbf37518-328d-c08c-7140-5d09d7a2674f@redhat.com> <87pm7f9q3q.fsf@gentoo.org> <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com>
In-Reply-To: <c50ac5e4-3f84-c52a-561d-de6530e617d7@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 May 2023 11:23:24 -0400
Message-ID: <CAHC9VhTX3ohxL0i3vT8sObQ+v+-TOK95+EH1DtJZdyMmrm3A2A@mail.gmail.com>
Subject: Re: [PATCH] sysctl: add config to make randomize_va_space RO
To:     David Hildenbrand <david@redhat.com>
Cc:     Sam James <sam@gentoo.org>,
        Michael McCracken <michael.mccracken@gmail.com>,
        linux-kernel@vger.kernel.org, serge@hallyn.com, tycho@tycho.pizza,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 11:15=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> On 05.05.23 09:46, Sam James wrote:
> > David Hildenbrand <david@redhat.com> writes:
> >> On 04.05.23 23:30, Michael McCracken wrote:
> >>> Add config RO_RANDMAP_SYSCTL to set the mode of the randomize_va_spac=
e
> >>> sysctl to 0444 to disallow all runtime changes. This will prevent
> >>> accidental changing of this value by a root service.
> >>> The config is disabled by default to avoid surprises.

...

> If we really care, not sure what's better: maybe we want to disallow
> disabling it only in a security lockdown kernel?

If we're bringing up the idea of Lockdown, controlling access to
randomize_va_space is possible with the use of LSMs.  One could easily
remove write access to randomize_va_space, even for tasks running as
root.

(On my Rawhide system with SELinux enabled)
% ls -Z /proc/sys/kernel/randomize_va_space
system_u:object_r:proc_security_t:s0 /proc/sys/kernel/randomize_va_space

--=20
paul-moore.com

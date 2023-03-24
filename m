Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF66C85A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCXTLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCXTL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:11:28 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F9D1B2E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:11:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so11758057ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679685086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qCK54soErGy7EGQQweZ79LKMpldqIoIIr3maQfIWTI=;
        b=UOvkjLSSWXE8wPVMQUnXmbQTKSI+J5aSEEF28D4EDDXXQtlme/YbjVNGyuwD5BR7qI
         IK4tu7kIcVw2SeZxFGB7pam+Y1eD2S6LDv4jtMuK2AJGAQZ5kwKY5F7wnPyhHD7q/Kpf
         bQNGWJYpKy12tIHBooUYqQYUwlsMppYtb3h2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679685086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qCK54soErGy7EGQQweZ79LKMpldqIoIIr3maQfIWTI=;
        b=Qpn1ZjHjtQVGK/7gh4wCxix5nGzJ7sQCrirSuz5p0FvCOBdbVlbTDd47A4uCKfv9BN
         T4WRnS8M5VqJZpZu3W7jo3WPsPHqzpyOF3DJUnCrjrHkY61rfynNyL/92rmUjuFlpKev
         jq/lYE8We77vUJCEvzpY2bPDhXQq4LV/ODmA0V0c/H9hjOYcLgW1C7O3QqoYHNIAmK41
         DMYS3XYt7SeBoFqdKiCf9gXhaHRtxvkDAZhLTYYEWFYLF0EK2JTXQog8scM4Tp2STwT9
         7suxdUsQqDQbmHBsyEqwrNouQGTfAanw5zEw+0KnZEiWzcaGeLwXg6rtRzqw9/iWtsoA
         u5ag==
X-Gm-Message-State: AAQBX9ftqWeo0gwl0nTT3580StcbKd2Mv6WCKH2K+66PVmucjj1dOIHl
        vwFMuAgwG157TGKgD2270WNBLNdYsHiCbKdJ/viNUQ==
X-Google-Smtp-Source: AKy350awIXMWnOSYQhyakablsuMA8xY3cDUgP3sSK7TMfmQcND1CD8TKN74l24GBPSVy19k496g1NQ==
X-Received: by 2002:a17:906:9c84:b0:932:3ca:e228 with SMTP id fj4-20020a1709069c8400b0093203cae228mr4634630ejc.0.1679685086134;
        Fri, 24 Mar 2023 12:11:26 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906694200b0092b546b57casm10661468ejs.195.2023.03.24.12.11.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 12:11:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id h8so11757678ede.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:11:24 -0700 (PDT)
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr1585791ejb.15.1679685084132; Fri, 24
 Mar 2023 12:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <ZBOsyBu68d4vh6yU@bombadil.infradead.org> <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com> <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org> <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org> <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
 <bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com> <582aa586-e69c-99bb-caf8-eda468c332b6@redhat.com>
 <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
In-Reply-To: <ZB3j3x4F2ozYX8UI@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Mar 2023 12:11:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
Message-ID: <CAHk-=wij=z-C6puGv+E5gGKgFMam-ucCjyji0-vP1wd=aUpFvQ@mail.gmail.com>
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted allocations
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        fan.ni@samsung.com, vincent.fu@samsung.com,
        a.manzanares@samsung.com, colin.i.king@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:54=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> +/*
> + * This clutch ensures we only allow a certain number concurrent threads=
 at a

kludge, not clutch.

And it's much worse than a kludge. It's just wrong and disgusting.

> +               pr_warn_ratelimited("kread_concurrent_max (%u) close to 0=
 (max_loads: %u), throttling...",
> +                                   atomic_read(&kread_concurrent_max),
> +                                   MAX_KREAD_CONCURRENT);

This is also wrong, since it's not kernel_read_file() that is the
problem, but whatever broken caller.

Yeah, yeah, in practice it's presumably always just finit_module()
doing kernel_read_file_from_fd(), but it's still *completely* wrong to
just say "function X is throttling" when "X" isn't the problem, and
doesn't tell what the _real_ problem is.

I really think this all needs some core fixing at the module layer,
not these kinds of horrific hacks.

          Linus

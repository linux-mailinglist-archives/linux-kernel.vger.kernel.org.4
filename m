Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A432764A9A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiLLVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiLLVoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:44:15 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2568413CCA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:44:15 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w26so863609pfj.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+ag/PhyV4lazzaYSTLTzsH3BZMXMT1SW00v66ePL4c=;
        b=hoXlROpzKSmvO37lOPrXW/ff8+sY5+Zu9u0y8qRxtFyMRPcHMtiujUoJEMNmxQMtyx
         5uTPAaNn1u5Hrl56fcYAaiIL9DdecnkOfi9VtUV+9ZWD071hR2fOqfGCRBl8vuvPqagR
         dZ6j0Jl1l4vfokpJAv9vBTaGZVHQQJU3Wp/2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+ag/PhyV4lazzaYSTLTzsH3BZMXMT1SW00v66ePL4c=;
        b=B9VboqbgNX8udV3yXDwbFe5vRTZy/vNiFuIjoCmiM9SeYtv2nXxIWz3ivlYAxPnF6n
         spLoHQO+8U0l0tqZxMBU9lujrXCOyAgHYUwC+k5Kt+GOcEP4syruBbFpjG+Cg8Yy0K/F
         95VaTgpaJI2hCjS7tq6KLSoJ900rrsNVG2lC7fQGD2GQ1wQGBzRSXz1nhzolu4MTUFRB
         e/EVr1Y13QPSrmuISnWUmkKIltqMko5Q+kYSAP+xp6l36qc3ZQAij5IqQPH3weuqFDVe
         v1tfpdO3LgaQlIYvUW7FK6wbSUYDOYMxVcpL+gO0buf0uYEwoI/rvIc5z7iJG74dZjtN
         vjNA==
X-Gm-Message-State: ANoB5pkJoXJkjV3roBQP7ugiZYXyuB/tFBeTGZN0QAqdZg60WPmDufG6
        qxj1hp2UHSm6s3PASw4Dh464lJhlcV37iCwvS1A=
X-Google-Smtp-Source: AA0mqf4h0Oj8ElXOi4qEjS3w+qZ7b3VecJh8ArNozoad57jLpX7z6RIDZVJX7S8hxC3oHuGi4zKWcQ==
X-Received: by 2002:a05:6a00:99f:b0:578:55d2:73ac with SMTP id u31-20020a056a00099f00b0057855d273acmr8799711pfg.0.1670881454511;
        Mon, 12 Dec 2022 13:44:14 -0800 (PST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7948b000000b0056b8b17f914sm6226947pfk.216.2022.12.12.13.44.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 13:44:11 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id gt4so1255487pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:44:10 -0800 (PST)
X-Received: by 2002:a17:90a:644f:b0:219:8132:70db with SMTP id
 y15-20020a17090a644f00b00219813270dbmr61283pjm.183.1670881450434; Mon, 12 Dec
 2022 13:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
 <20221117160650.16e06b37@rotkaeppchen> <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
 <20221121150948.6f7c1f1f@rotkaeppchen> <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
 <20221124124000.5af23cad@rotkaeppchen> <CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
 <20221124160115.23ae7928@rotkaeppchen> <20221128114200.72b3e2fe@gandalf.local.home>
 <20221129144450.75a7181e@rotkaeppchen> <20221129093245.599903e7@gandalf.local.home>
In-Reply-To: <20221129093245.599903e7@gandalf.local.home>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 12 Dec 2022 22:43:59 +0100
X-Gmail-Original-Message-ID: <CANiDSCs6jyNBiO+wO-MHB3qv5am0mmGbv7y4eHv1PSLQh5EPTA@mail.gmail.com>
Message-ID: <CANiDSCs6jyNBiO+wO-MHB3qv5am0mmGbv7y4eHv1PSLQh5EPTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp

On Tue, 29 Nov 2022 at 15:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 29 Nov 2022 14:44:50 +0100
> Philipp Rudo <prudo@redhat.com> wrote:
>
> > An alternative approach and sort of compromise I see is to convert
> > kexec_load_disabled from a simple on/off switch to a counter on how
> > often a kexec load can be made (in practice a tristate on/off/one-shot
> > should be sufficient). Ideally the reboot and panic path will
> > have separate counters. With that you could for example use
> > kexec_load_limit.reboot=0 and kexec_load_limit.panic=1 to disable the
> > load of images for reboot while still allow to load a crash kernel
> > once. With this you have the flexibility you need while also preventing
> > a race where an attacker overwrites your crash kernel before you can
> > toggle the switch. What do you think?
>
> I actually like this idea :-)

In case you missed it.  I sent an initial implementation of this at
https://lore.kernel.org/lkml/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org/

Regards!

>
> -- Steve



-- 
Ricardo Ribalda

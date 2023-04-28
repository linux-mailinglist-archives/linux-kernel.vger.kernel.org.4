Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C4F6F16F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbjD1LkR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjD1LkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 07:40:15 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670B5265;
        Fri, 28 Apr 2023 04:40:15 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso276899766b.0;
        Fri, 28 Apr 2023 04:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682682013; x=1685274013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Zy6dDIYyXzp/IIArHG+J8CnNNLzaaPGEgAIKwaz0A=;
        b=NpAxkS6xP/Ir9lwKrjTGpOsRWW2UvHkCem7X+FbHtZixRLCj4dq8eIheln+gSeYnmK
         /KIHRSJERjtHsp5+N//hKUeU5udmrFmUJO4EBfqgQEvh8TtqjNtXEwemFqRiGlXEBjkW
         aN2YCUhJ3yHYAjDapXT2bOealoxtsRdVzDubuLOk24dF1abYrCHtouRj2/7+W8cXU6Oo
         lrU6bq7X6t6gjcocmEY987+TK25UuOYgT9rVdvyS2XIflZB8wNwf5HRjYdA7A3rLVGc5
         d9KvC1vaBivFqtJEEBf85bbXtJQW7IhJU2lJtdyNSAC60Ki+8Jjnv16so7ZHBCrlW78J
         x4Jg==
X-Gm-Message-State: AC+VfDzV49nW1qEciXExY7hoeAYnVAFhf8SLZG9qhBzNKQQvysr3b2j6
        TSdE96qVj6dspRUHcZYsiGMULBkof7wpf4Vz8OE=
X-Google-Smtp-Source: ACHHUZ4YSna+vQuV5WC7eJ1T2zbiL4affaII1I+1BXPZjyzf9iEOeRYuRVF/G0/cxYzvwDUu/1XpxmmYAyB4RI5DJDI=
X-Received: by 2002:a17:906:739e:b0:929:b101:937d with SMTP id
 f30-20020a170906739e00b00929b101937dmr4655738ejl.1.1682682013422; Fri, 28 Apr
 2023 04:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230427221625.116050-1-opendmb@gmail.com> <20230427221625.116050-4-opendmb@gmail.com>
 <ZEtP3uRX5Ib1W_Kd@kroah.com>
In-Reply-To: <ZEtP3uRX5Ib1W_Kd@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Apr 2023 13:40:00 +0200
Message-ID: <CAJZ5v0jFAkBUAhNj8hbpM+6n1F3ETTtpxeP_QDsmKWdE=uueFw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] Revert "input: gpio-keys - use device_pm_move_to_tail"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Berger <opendmb@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Saravana Kannan <saravanak@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 6:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 27, 2023 at 03:16:25PM -0700, Doug Berger wrote:
> > This reverts commit 2569873096f7eb1acf63624e9772d82b23923bf4.
>
> You have to give a reason why you are reverting it please...

Also, the commit ID above doesn't match any commits in the mainline.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA5F6CADE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjC0SuZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 14:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjC0SuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:50:13 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A544A3;
        Mon, 27 Mar 2023 11:50:02 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id b20so40285415edd.1;
        Mon, 27 Mar 2023 11:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679943000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNp6bTzVcYhi3ofxJvpWDnNllLRIZ9VGER6udP3GxAw=;
        b=xwPWXfKrZTug6emx+Im3MR35IhHapGNMl4B6F9fXaSOEDIMxodxX+WCZy2vXoyuOU2
         58ttMx4kWpkn+wZQwn4L1QtxgGi3OinNRQQMY6osJwOiorfbgXbVcw48CbMRGuj8t9fJ
         9SQUffckKlO2t/nri37uLt52NyL3O4YOGygE+zScFA5qAiEKe9wG490VjpDUTtVbJ9im
         l68TdAIdfdIp5gJg/Qfy7y6cACiJmYUTAy5sIDhchCB+g8RRG/90CEkVHUiIYU1JE9P/
         Mf+vMtiO6PLd/f7/aD+7cz7vZsvzaBtMvmubxBByN3Hl0qUOoa1zKM42sEicKf/iTnva
         QBgA==
X-Gm-Message-State: AAQBX9c1FpSk2p4t1zsdCZE70MEQP500jYD1HNSeGWPppN4pm+GYt1Wc
        rq7PVv/7lttD/5FW70qcAgu9JX9eI81xNcplwSo/F+At
X-Google-Smtp-Source: AKy350axdBY+5VN+YNbBNM4/DUOCVZ3diMfFpguJfSpGU+HJ+4vOWzTNntOg57X6uVw8VD24NMgoD35FVniPJf7lSfc=
X-Received: by 2002:a17:906:37c8:b0:934:b5d6:14d0 with SMTP id
 o8-20020a17090637c800b00934b5d614d0mr6596159ejc.2.1679943000671; Mon, 27 Mar
 2023 11:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230324114146.4037-1-andriy.shevchenko@linux.intel.com> <ZCFnssNwMgjKCX9L@kekkonen.localdomain>
In-Reply-To: <ZCFnssNwMgjKCX9L@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 20:49:49 +0200
Message-ID: <CAJZ5v0iUOx4w+sr5g=Yo2KOvLw_dDGqLp9MKdSqYq2TSduEvUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: property: Refactor acpi_data_prop_read_single()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:54 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Andy,
>
> Thanks for the patch.
>
> On Fri, Mar 24, 2023 at 01:41:46PM +0200, Andy Shevchenko wrote:
> > Refactor acpi_data_prop_read_single() for decreased indentation
> > and better structure. No functional changes intended.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Applied as 6.4 material, thanks!

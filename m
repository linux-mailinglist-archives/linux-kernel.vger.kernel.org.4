Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996326CAA54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjC0QRq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjC0QRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:17:36 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52D5FCD;
        Mon, 27 Mar 2023 09:17:04 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id b20so38530905edd.1;
        Mon, 27 Mar 2023 09:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679933812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxPtolN39h2PLfA1b2YCugQifzSuo9B122mhTUOTwWk=;
        b=BI8AfE8/QvUaOAYiSsqgInyjhGSv7+YnoRX6MuaPHcRrrweyp/iBViIC2f6KFDzXlM
         D1OD4WxeSx17tqub8rnANXP3EbrnR78NagwnPYDA8+CviqoyGI0tsWn/REkdp8JnepYm
         S4mmfh+FE3tTRiPhPolhkIt6tIWAO87CuVje6c9sExQe1Ka3VOaBYROATrP2lH3AktYc
         1np/xAWDW/i8jQ92jClae9IlfEZ0s9Shj2PwdCQQfk/jeykiptq+5tQxNDfTr3BrGOP1
         XPbCDC1qMZA+Hoy6qygZns8jpKLw0tsWbT46XxhsBx2ouPmRTqgJnlu/YTaTAs8SbCwC
         TWag==
X-Gm-Message-State: AAQBX9csaBXHDz9EeNxYIbFhg4c3MmybbERPsE7nBsphvp1mi6IM8Fxv
        1xThcGRKS//Nro0ifEtMNOoUlt1TJxtaVVmv2AM=
X-Google-Smtp-Source: AKy350aaYoiVU1D2NAgL7MckmXbcMbIzlqVSmHA3O8q4kPD4hJT3CIQdm5RxbHrlc1Nk1hiPHLjBXd9Ved4a6NggsjY=
X-Received: by 2002:a17:907:3e8b:b0:931:ce20:db6e with SMTP id
 hs11-20020a1709073e8b00b00931ce20db6emr6710511ejc.2.1679933812554; Mon, 27
 Mar 2023 09:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230307133735.90772-1-daniel.lezcano@linaro.org> <20230307133735.90772-10-daniel.lezcano@linaro.org>
In-Reply-To: <20230307133735.90772-10-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 18:16:41 +0200
Message-ID: <CAJZ5v0hW1B7XmU16PHRE2B6z2e-qs=X8m4v8qb--MUttiPuGqw@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] thermal/core: Add a linked device parameter
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, amitk@kernel.org,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com
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

On Tue, Mar 7, 2023 at 2:38 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> Some drivers want to create a link from the thermal zone to the device
> sysfs entry and vice versa.

Which device is this, exactly?

> That is the case of the APCI driver.
>
> Having a backpointer from the device to the thermal zone sounds akward
> as we can have the same device instantiating multiple thermal zones so
> there will be a conflict while creating the second link with the same
> name. Moreover, the userspace has enough information to build the
> dependency from the thermal zone device link without having this cyclic
> link from the device to thermal zone.
>
> Anyway, everything in its time.
>
> This change allows to create a these cyclic links tz <-> device as
> ACPI does and will allow to remove the code in the ACPI driver.

Well, I'd rather have it in the driver than in the core TBH.

If ACPI is the only user of this, let it do the dirty thing by itself.

There are two cases which would justify making this change:
1. There will be more users of it going forward (seems unlikely from
the description).
2. It gets in the way of some other changes somehow.

I kind of expect 2. to be the case, so how does it get in the way?

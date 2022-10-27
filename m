Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC3B60FC5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiJ0Pvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiJ0Pvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:51:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712BE141388
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:51:26 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id 63so1877670iov.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dozLLyjKjqHhb+X0acBLKw9IjdLm5xj2ebLr4rNdoek=;
        b=QEUKYJ5XpOUdpbO3IpoLPnX8wuqiX+Ha7nGFYn/28VUjh6r4J4gP9Ie3YKjpQ6YnxP
         kuqhZyUh+ovtgz9mzVpYzA+/AFOiiWzGzELXBTFlbdtCjVk+y//lc3SQEtSU3jO2x8/z
         hHERZmdYQwXQ04VEy50yVMS1Wt6ILH1KPLD58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dozLLyjKjqHhb+X0acBLKw9IjdLm5xj2ebLr4rNdoek=;
        b=wOj0V5LWUENRL+Y4uiSYqPr0kt4vlVPkGgmyDs6fpcIU8+VGHcP1pmZwY14aJ1HBu8
         fYjLszfKuO65UOiQJkMxs1Cv0YZGnGlK0jFCVDO/4ELd+q+0xRuY7CCuyt0rBlc2WcM2
         excxQxikCIkBj+pZ4LAObXVlEtI/Q68AfHsHbPo/40d+5gqA1yTqSGUKGLRC1I27qRPV
         vEWb61AF9MuQ1Lzi4FrzasQPuZLacO4K6KKCJI/A10/k+oocWtIzAEXMm/XKAPe/ftU3
         R2iSvVtwoSsDMOOaQ5Eu57hcYdhOv2Y1PEOCPghEPuLBUgKk6ZHNoKm4/LErAmRkki/M
         3ySA==
X-Gm-Message-State: ACrzQf32zTwGDpIBMTAMQxR5SQAB4P7DNfCszhVuwlgGPc74Q9bmkHGr
        uXt0O1FGd8QQv/6znESqs4Ol/QOGQY9fL2Ags884qQ==
X-Google-Smtp-Source: AMsMyM5+k8oMSIJoYJjGQualIXDGLE2i4mR1iAbC8CMNclPTZYCdXQJ/Lj61ZnFfJX8LEro5WQrply5IguQSeM9aQDU=
X-Received: by 2002:a05:6638:138c:b0:364:4c3:eafc with SMTP id
 w12-20020a056638138c00b0036404c3eafcmr5456507jad.163.1666885885933; Thu, 27
 Oct 2022 08:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221027151908.v1.1.I295e65357f06f162b46ea6fc6c03be37e3978bdc@changeid>
 <4b7304c0-8dd5-9add-7c84-4e9f0aa9396b@redhat.com> <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB6101BCCA364437A76FED924AE2339@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 27 Oct 2022 11:51:15 -0400
Message-ID: <CAG-rBijvNoN3ppz6bdkEUofYPPBxCtFfo1nWBK5TdG69fcKMnA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/x86: intel_pmc_core: promote S0ix failure
 warn() to WARN()
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rrangel@chromium.org" <rrangel@chromium.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Rajat Jain <rajatja@google.com>,
        David E Box <david.e.box@intel.com>,
        Mark Gross <markgross@kernel.org>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:47 AM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> If we do make changes to this message level so that other infrastructure picks up I suggest
> we do it for both drivers.

Sounds good, patch feedback willing.

> WARN() is really only intended for internal kernel bugs and not for
> hw misbehaving, so I'm not a fan of the change you are suggesting here.

Thanks, I was not aware of this distinction. But it does look like upper-case
WARN is already used in many places to indicate hw misbehaving?

Here for example:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/chrome/cros_ec.c?h=v6.1-rc2#n142

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFAA68BA82
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBFKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBFKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:39:23 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94F672B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:38:48 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id s76so5862681vkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 02:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QPWW4zL1NFKCrSCbOBCpHHp+YFmxnGGneAK8ociNPKQ=;
        b=i2WZN3sf4aR+uP3iV+9FxqiJahHoQiVIeFCi8TzHvFrmO+dKs7arBVfdUPdog77fWz
         sRgv4iSVT0UuEuiUdsGYMeDNzspA4gwmR4pyjVNPPdXXNDjWaTyamBlphL441kO4G0dk
         EYdY8Wc+prNJPeo60x9V3aLlrng1SEezyZTHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPWW4zL1NFKCrSCbOBCpHHp+YFmxnGGneAK8ociNPKQ=;
        b=v5O76qHIhFhcXAne3HH53NohQSnveyHJfMXyCat+jinBDq57ePyR4s8TPUeSqroQ1W
         COnpchX8RBVV7U3uhVDF+2d9EqOWVzbePy9fA7tlOwQZaWT22VhQMnQ3M9ILGFTxOlCV
         SQxp/tv9zt5uXJ5bEE2dSB1DJG2O1H+CXYXN0vQUx6hlKLyiMn36vmKKNYw+uIGSEhTF
         cEoEBRlNJqJhPQAusGsEwnoLfaUvZtx80XfmEHXXQl8J/Ybv8QfzTqVLl8ey34CG6dIv
         J1kRXt2IfXNIj1cYENXBCHEra21ak4TYzdNTRT3HZCWmhCQtS6+LbaMi5rBeYj9tfENT
         BabA==
X-Gm-Message-State: AO0yUKX2Mmn7YjFuBFs+xyz6zkrMfASbQYD5Bij+O9o4QW8ObrNshy3l
        tF86AWaJSk7fDNr9NocOhK3gbl4s6ZdBti5NoLiZ9w==
X-Google-Smtp-Source: AK7set+pgcRuc2/Iw0usOcV+y1OnDzgPcImUYBj4Nzb5JjiqLSsfHX5XI0z//fcs6XQgo9T4jZDcyU+1tieO0Yhe0eM=
X-Received: by 2002:a05:6122:b76:b0:3ea:62fd:bd85 with SMTP id
 h22-20020a0561220b7600b003ea62fdbd85mr2910109vkf.0.1675679877767; Mon, 06 Feb
 2023 02:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20221121190020.66548-1-avromanov@sberdevices.ru>
 <Y3vjQ7VJYUEWl2uc@cmpxchg.org> <Y3w7VP5CKvm6XmoJ@google.com>
 <Y3w8/q/HoSbqamoD@google.com> <20221122121413.ssieckg523urj37h@cab-wsm-0029881.lan>
 <Y32eA93V7w1Wu3VH@google.com> <20221123085306.52ozfjimaeikcbof@CAB-WSD-L081021>
 <20221201101417.f6qm4v3m7ibh3l72@CAB-WSD-L081021> <Y4iGOTRvAS+WRrtq@google.com>
 <20230111140046.ls5vitsymjz47uba@cab-wsm-0029881.sigma.sbrf.ru>
In-Reply-To: <20230111140046.ls5vitsymjz47uba@cab-wsm-0029881.sigma.sbrf.ru>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Mon, 6 Feb 2023 19:37:46 +0900
Message-ID: <CA+_sParwBrjBvsaCmnqqov_Skz6JD-m2i-1PBggk8c4eo2aVOA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/4] Introduce merge identical pages mechanism
To:     Alexey Romanov <AVRomanov@sberdevices.ru>
Cc:     Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 11, 2023 at 11:00 PM Alexey Romanov
<AVRomanov@sberdevices.ru> wrote:
>
> Is there any news about the patent, lawyers and my patchset?

I'll get back to you once I have any updates.

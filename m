Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD1869223B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjBJPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjBJPco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:32:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFDB26CE3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:32:37 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n2so3958333pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mPBNK2ej0BcprMRPxKQMTVYdpw2TzIpWU9/H8oT8YJo=;
        b=RaNa89YU3dnVZsXe8utP85ovLotCy8RlCIohNljxuulqSfgVmzgUPpgaPtRvq1eS9M
         hOe2ZyYcIzWlfeMLwSJN51TGErCqEqgm0m/VIpBQOJO9orMJE8pVxBaBnwVEfdNdHEJA
         7aLbz2ekAdOaHxfk6tDYi5qU/ziAVOxSp3wO86NnjEgwGKGDcecBH3uyNMTsNl9MQDVh
         aqqfa+MbSPyAoEmB/OXmmqjX6gDKy1IndCPsqpudaTxfned8c2wx28K3wCfnHq6aEvxb
         JclXUUcvrgnF7Wo0O63NWkjt4J2jtAhj8bieRBlvXtfy7/e3jlI+mrn/6szex1P36ynQ
         L5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPBNK2ej0BcprMRPxKQMTVYdpw2TzIpWU9/H8oT8YJo=;
        b=Qb0jUGnwUlFIGEF7H2aBmqw021fYRGy05xgsnmVhXbomuQ9TmeDRJk/NB0qDqZ0dq5
         v1fO3OOVs7+jVM/tM9LEznSlqiiFizzgZPgYtn63HKnGNnmI6a8x4AN5LVIZ/VhdWD22
         e60MHU21UC5lPf7cHIJAdvXcG9Nt8gi2Tex3KNApwf7wqpl26I+UHnSAhpDolD+OMoMv
         vdlbtyH6LsAR5hWq1nY8DWCSgBLgtYW8OGS989IduSoeOI9RZlq8xr8OjzTw3Q60MeEF
         MX5VnhENFPs3h6OO+eNRkVxM5BXsbnMNrj5SIFnUMnDYaAX4Xu8LJZT2yAxRrQvSdCJ5
         qcxw==
X-Gm-Message-State: AO0yUKUtERhLm4Mt4RYO1M+TbCuH/CnTrguaS/mixY6k27zcJVuzVTez
        QtpIqjgpdVSJ+xDrxwsyLmrrjHKT110qzqqzDm0FGg==
X-Google-Smtp-Source: AK7set80aQ9xcQwY2+x8LZ6BGoeVxxb+rQE+8nMGr7c4kTumDEitmRxGlXj6kAWZbyV7yY1JYBLhO3Sf+Tjln94H3pQ=
X-Received: by 2002:a63:7f4d:0:b0:4fb:2d7e:998d with SMTP id
 p13-20020a637f4d000000b004fb2d7e998dmr2146063pgn.123.1676043157502; Fri, 10
 Feb 2023 07:32:37 -0800 (PST)
MIME-Version: 1.0
References: <20221208075604.811710-1-junxiao.chang@intel.com>
 <BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com>
 <Y6H4zqr8bObRFE1g@linutronix.de>
In-Reply-To: <Y6H4zqr8bObRFE1g@linutronix.de>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Fri, 10 Feb 2023 07:32:26 -0800
Message-ID: <CAFzL-7sL6HVDyVbafaxiq7-KN1aDTFUx8az4h0EvxJmuO6SPog@mail.gmail.com>
Subject: Re: [PATCH] softirq: wake up ktimer thread in softirq context
To:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc:     "Chang, Junxiao" <junxiao.chang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Peh, Hock Zhang" <hock.zhang.peh@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:03 AM bigeasy@linutronix.de
<bigeasy@linutronix.de> wrote:
>
> On 2022-12-20 10:44:07 [+0000], Chang, Junxiao wrote:
> > Any comment? This patch is for 6.1-rt, issue could be reproduced with 5.19-rt kernel as well.
>
> Thanks for the ping. I did see the initial email and I didn't get to it
> yet. I need to re-test, confirm and then apply.
> The ktimer patch is not in v5.15 and this is currently the latest one
> maintained by the stable team. I don't know which one will be the
> following LTS kernel but this one needs to have this addressed. The
> v5.19 is not receiving any updates.
> Given the current timing, I will look into this in January.
>
> > Regards,
> > Junxiao
>
> Sebastian

Should users of ktimers adopt Junxiao Chang's patch

https://lore.kernel.org/linux-rt-users/BN9PR11MB5370BA8A506EB8519DC879C1ECEA9@BN9PR11MB5370.namprd11.prod.outlook.com/

from 20 Dec?   It appears to be a bug fix.

Thanks,
Alison Chaiken
Aurora Innovation

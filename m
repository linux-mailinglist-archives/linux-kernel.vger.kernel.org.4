Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F53724BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbjFFSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbjFFSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:44:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B7310F2;
        Tue,  6 Jun 2023 11:44:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-654f8b56807so3832863b3a.1;
        Tue, 06 Jun 2023 11:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686077089; x=1688669089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnxSGX9RGEOsuf5fjVZlUilqBnK9L4Q5QcWfPvvT188=;
        b=Hv2MAbOsi/py9dCB1OT98jVelXiGsC0q4zvrD9Qpel0UuNQ9B90H/Zllw9TUP0Kg5A
         liJANCu79rkr4JjLRDujReUbR5PbF1v6dxqR0TV47gRMkpTeQ12IxC0AQsXL9PXNsjFD
         qYJHl4SAY2crpAcWmA+tqIKgYdnX5c/okpK6JjOGGewfIsDr32My/5Bk+rHrTz/8vBy9
         vKKyNq8i/Ojm7LRsaN82KAplE8LIm4cjL8debuesp/e36zupmmbWo8H8DkELbsKq/8uH
         M9gsF6jmya5hL5X/1wursH8O08HqOgpT3/ygARu8OlyfBJF67jllwRmWtPFj0lvoYrYo
         Ug7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077089; x=1688669089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnxSGX9RGEOsuf5fjVZlUilqBnK9L4Q5QcWfPvvT188=;
        b=Jsb+50e3xpKOpBzqfvtrIXlSSI4aNLqJ09pyPu6apukjUoiddHl63jeehh6iAYp+5R
         XiU5epeEOmkqgk9lqoCj6uaireHUh31jrWJyT+TsJCbzmmHZ4UPU3PUpIqiQg/z/Aewn
         38eH8ldLyxijdOdZc/1kAtt10G9+sAwZgpgFpJImsMKB7v03ehiLLgQPefpRgzac6ZiS
         xIld9Yd/pckvtkQq44zUyRUR/dyje5sz+m0EzppzaBRvB1kjGxqDqV5f8ljP1v2zqA1E
         5e1nEdyAvbRYDYEcb+es2jcnhp3Bkxi7VLalWlMpEfNCJKPpDhjsR/a79fHZnwgQNjLD
         SlmA==
X-Gm-Message-State: AC+VfDxlGT9/RwvYBaenqE5k8Z6OODRuwBrf4PzuG0QXyIwu9fRC421M
        bqCa/yPQxaNNk8IofLQ27lf7H6Qa1jM=
X-Google-Smtp-Source: ACHHUZ523BriC290f52yLBtVXtFdVlswsx2c4CEmtBlS/+X26VhDJT1Qhga24PXNO6FQyymBEDhf4g==
X-Received: by 2002:a05:6a00:c8c:b0:64f:52c9:ddd5 with SMTP id a12-20020a056a000c8c00b0064f52c9ddd5mr3888893pfv.34.1686077088947;
        Tue, 06 Jun 2023 11:44:48 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id j17-20020aa79291000000b006410f4f3ecdsm7118044pfa.83.2023.06.06.11.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:44:48 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:44:45 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] input: touchscreen: add initial support for
 Goodix Berlin touchscreen IC
Message-ID: <ZH9+ndrF0RIgFhnI@google.com>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
 <f5f20de8-851a-fe20-4664-62b6de14ebd7@redhat.com>
 <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2677ae8c-59d3-b658-dc3f-918838ac0fb6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:12:04PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 06/06/2023 17:31, Hans de Goede wrote:
> > Hi Neil,
> > 
> > On 6/6/23 16:31, Neil Armstrong wrote:
> > > These touchscreen ICs support SPI, I2C and I3C interface, up to
> > > 10 finger touch, stylus and gestures events.
> > > 
> > > This initial driver is derived from the Goodix goodix_ts_berlin
> > > available at [1] and [2] and only supports the GT9916 IC
> > > present on the Qualcomm SM8550 MTP & QRD touch panel.
> > > 
> > > The current implementation only supports BerlinD, aka GT9916.
> > > 
> > > Support for advanced features like:
> > > - Firmware & config update
> > > - Stylus events
> > > - Gestures events
> > > - Previous revisions support (BerlinA or BerlinB)
> > > is not included in current version.
> > > 
> > > The current support will work with currently flashed firmware
> > > and config, and bail out if firmware or config aren't flashed yet.
> > 
> > What I'm missing here / in the commit msg of
> > "input: touchscreen: add core support for Goodix Berlin Touchscreen IC"
> > 
> > is an explanation why this is a new driver instead of adding
> > support to the existing goodix.c code.
> > 
> > I assume you have good reasons for this, but it would be good
> > if you can write the reasons for this down.
> 
> Sure, should I write it down here and/or update the commit message in a new revision ?
> 
> Anyway, here's the reasons:
> - globally the event handling "looks like" the current goodix.c, but again the offsets
> are again different and none of the register address are the same, and unlike the current
> support all registers are provided by the "ic_info" structure
> - while with the current code it *could* be possible to merge it, with a lot of changes,
> the firmware management looks really different, and it would be really hard to merge.
> 
> But I may be wrong, and may be misleaded by the goodix driver structure (even if it
> went through a really heavy cleaning process).
> 
> Globally it seems they tried to match the "event handling" process of the previous
> generations, but the firmware interface is completely different.

It is not unprecedented for drivers to share event processing and
implement several ways/generations of firmware update mechanisms.

Thanks.

-- 
Dmitry

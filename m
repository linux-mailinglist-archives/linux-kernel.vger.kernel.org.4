Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607672E793
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242638AbjFMPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbjFMPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:46:21 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDE418C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:46:19 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b3be6c0b4cso17312115ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686671179; x=1689263179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DycG4W9rFQOA5mqe7LcQiptnT0e+7vh1h/UF+fmSM40=;
        b=JQKTaGzTIydGJ0kOanyBvSENtY2ieQk1DsYGafj6/MGszzMriE2v3AqbAhNjyQF9CR
         Cae0HTS6JLKN48nkxf3PEdWivZ4vWc6OxqCjTIIl8PEYfL9hQFMXpeo+s3I5g8PEVLNr
         OGxfIxj8Tw4WNwhKe1X2EsedvPsz0d4zGGFwjoD2NU6vVk1TjhPiVREpYiOsgVtAIpOW
         Os31hABT4E0viFTlaPL76OHa8DJhPXeQLQQkxWEs3hSiKoEkd8wzp+N265640zl6u0wO
         rd466RzICNzu8Grr4s8Ec2xBdL/BirxvyAI7PfksvtOu6yh55wKkop9fYcJIbmbdy0ux
         O8Ig==
X-Gm-Message-State: AC+VfDya01OotwkoDXV+F7MHJadK7Pptb3EvbvFONq4RjaR10oZS2aHa
        Z4wrsNEyP3h8MkprQyexmss/DQ==
X-Google-Smtp-Source: ACHHUZ57ihyk/UnWUTc8fZnPloB6lQh8V/nD/R7t1VZlIHIgcTPby2SjniCB4PIGKmfv8C5HcaZS3Q==
X-Received: by 2002:a17:903:120c:b0:1ae:305f:e949 with SMTP id l12-20020a170903120c00b001ae305fe949mr9690010plh.6.1686671178914;
        Tue, 13 Jun 2023 08:46:18 -0700 (PDT)
Received: from localhost ([75.172.135.98])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902848200b001b3ab80381csm6439130plo.301.2023.06.13.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 08:46:18 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
In-Reply-To: <ca6a5f0cd1f64368045df05ba048e31d.sboyd@kernel.org>
References: <20230511133226.913600-1-msp@baylibre.com>
 <20230523114618.laajn2et5nbcxszv@blmsp> <7hsfbjxcqs.fsf@baylibre.com>
 <7ha5x8xzrp.fsf@baylibre.com>
 <ca6a5f0cd1f64368045df05ba048e31d.sboyd@kernel.org>
Date:   Tue, 13 Jun 2023 08:46:17 -0700
Message-ID: <7hv8frwek6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Boyd <sboyd@kernel.org> writes:

> Quoting Kevin Hilman (2023-06-09 11:21:30)
>> Kevin Hilman <khilman@kernel.org> writes:
>> 
>> > Markus Schneider-Pargmann <msp@baylibre.com> writes:
>> >
>> >> just wanted to ask if I need to do something specific for it to go into
>> >> a rc? Sorry if I missed doing something for that, I haven't had to fix
>> >> something in an rc that often before.
>> >
>> > I think the  Fixes tag is enough to indicate that.
>> >
>> > Steven, is there still time for this fix be queued up for v6.4-rc?
>> 
>> Steven: gentle reminder ping.
>
> Who's Steven :)

Sorry, I confused you with Steven Spielberg.  I bet that happens to you
a lot on the mailing list. ;)   (either that, or I can't spell.)

Thanks for queuing this up Stephen. 

Kevin

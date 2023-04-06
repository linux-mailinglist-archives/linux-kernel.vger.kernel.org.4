Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922756DA1CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbjDFTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjDFToS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:44:18 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B342386B4;
        Thu,  6 Apr 2023 12:44:15 -0700 (PDT)
Received: from localhost ([31.220.116.195]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MzR0i-1qfvUj2ofg-00vLXw; Thu, 06 Apr 2023 21:43:57 +0200
Date:   Thu, 6 Apr 2023 21:43:57 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: Honeywell mpr pressure sensor
Message-ID: <ZC8g/dfMYWZcW4zg@arbad>
References: <20230401185717.1b971617@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401185717.1b971617@jic23-huawei>
X-Provags-ID: V03:K1:eSF7yy9nXHf5SFVRJlz/mjUZOLX5Kpo0ju039iOa+ryPGz/lmSr
 XxpS0TGoqUT/ys9jdA38+uDHQ+GviypepRIftFGiVu/nJA7OUssQWU1l8ZQCSepvNtX5D4j
 TWOhKOOt00311MgH4hB91ZH6lAafrF7P4nxnTyhWCO4k3+cTknZb6r4FhA06+CI4eBW0QLO
 fMBNLH8JMVfoObtvi9RWg==
UI-OutboundReport: notjunk:1;M01:P0:QYJIZEuSZU4=;rtzbL/dL5fcU4v/ErbYUA7oc8Zo
 9Fem+P98U7oEvwhh+Xj8CL6HfDP7ocUjH8LgISr2Jcf2UbAwmsZcOD7tfyaLWPqkL8RsgiUDX
 qYaASNl5B8vvDAGf/BOZCQtlmKvScCiEiRwLZzz+1BW8/nPiEKdk1r9dxBEXtjQHysoUs+l2Y
 Hymv7oDNWcfIODBz4pc9chg4wpFXK8LNUy0fBFMFpxJWAfU9/5BhumqcSl7Q778kBc4ivlb19
 XdRgldANPjZL+V7iD2s+tetc0Z79y4BYSiTJl5itzy8B7pY8RJaUp0kON2xL8fV1fFACyjwec
 EjiKvOryRLhwPgBsTEtoqzpClwLOzJI8bsuG0y8+S0u4x2tr4ufk7z/zwKjWK4ZQ3rpy/JLOK
 0RiaNODS1VzqzBoWW+FTCpPShX6VNbhylxi4P8hQtSeb8P9MniBG0Y0PwDgiBPDHICoNGoRnS
 U5pCU4GyfSIeFYrOfLLbbno7jhm5CAS7etYWYJxinsBbxrMDDkrdNGbrTuL/ZuOEd5/np+WwK
 RsPnyRMbfXGR//FniJKMg2KQ0EBRikveYMFSPmaGZsq13yf0mbMrUnygPSK9MS1OcTauQinLe
 +ostEJRhc+jVKi1jfUa6a0xoun4093tRL6nQrDzCGbApJ8mnuOrKY/0DREShe7eobl0Zcxcmv
 +JULuUgmgLasBVXjAI4KrazSAS9+l+iaWYZkr+lOaQ==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

thanks for the extensive review. Most of it is clear but one questions remain.
See below.

Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 01. Apr 18:57:
> > +static void mpr_reset(struct mpr_data *data)
> > +{
> > +	if (data->gpiod_reset) {
> > +		gpiod_set_value(data->gpiod_reset, 0);
> > +		udelay(10);
> > +		gpiod_set_value(data->gpiod_reset, 1);
> > +	}
> 
> If there isn't a reset signal, I'd like to see an attempt at least to write
> all configuration registers to a known value (same as the one you'd
> get after reset).  

There is no configuration register in the sensor I could write to. But maybe I
didn't comprehend your point.

Andreas


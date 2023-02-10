Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E0D692599
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjBJSpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjBJSpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:45:19 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C437730;
        Fri, 10 Feb 2023 10:45:15 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-16aa71c1600so7783597fac.11;
        Fri, 10 Feb 2023 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSmWk4P1YdFXvxvTiIVgI852UVWnz4vy/QS6724V8nM=;
        b=AgHc2OLZAJTXrrYhFJxKcHFJ80JZaMxxY0zBeovUHhkMVvICh1SlBt2y49oTdA1Kdh
         cCBf+qLh6qmKG2l6A2n1SFFnjnfeLTRJ/gt0H+8AWHo7tR2dQBGvdCEgyjpLBBOdhKaL
         dxtBqF7fXoLRI8S0lJEvMMGCy2mX/qsbThJC8S2cxsgCxSWM0N/+KqbvBrvdcAlV+Kss
         BgCcRWjSZlBGhbeS/fjrgwPDx8TBPiIi/IeaC9OWwLazVT+PQikjfxyhb4pYrZ2t1w/B
         WHAzSc76Bq/j2Ch6kWZT1qX4amxS0z4Oc9OAqtkce3FW5naNQEWX5tMjG7NhejSYavNZ
         uv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MSmWk4P1YdFXvxvTiIVgI852UVWnz4vy/QS6724V8nM=;
        b=aQf3p1oDc0vCN1VFzRWX8mhLgbv1qTM1yfMA1g8q0EQlZaADYHF+1glZeOQ6fEei8g
         2uninkkcWM0YGaFnXFpZezegXTuTtGtW8yrN1+qLJmfVXQ0iANL4/zMw+65thejU94A8
         H7xGYtxfGBPynkZLF8s4a04C3DPM/iyxlvmGM/PafGrF3YKFiueAmicpzZ/o2L8DRpz5
         XP+t9MNtuQjyVuALLhCpXza57D7U7rB0F6V714Sd28466yMZfVXA1TZUobgkKaFimxnk
         qcvDnBUYLqbPIEV74KlvOIFsB+/rNrAuSyzpnTobfXbBhK+Q/pvWB/KARg0R/D6NgOD8
         6jxw==
X-Gm-Message-State: AO0yUKXocsVAS0fEkDXqHOZLlO2BC8M4Yh9r/diRiDeMShhBQRZuV4Dr
        d04NU+XJhvzCxUkJPP6jS2RABjEJRAs=
X-Google-Smtp-Source: AK7set9rlFZaa4Xbho8YO0ab2EMSQTJxPs8a3sqTk1xN+SDFoM69Vcqd1wLHwmQigcarQSBMBLcDbw==
X-Received: by 2002:a05:6870:a797:b0:163:2d8e:55a7 with SMTP id x23-20020a056870a79700b001632d8e55a7mr7367961oao.24.1676054714141;
        Fri, 10 Feb 2023 10:45:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y20-20020a056870429400b0016a2330dc21sm2234801oah.0.2023.02.10.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:45:13 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Feb 2023 10:45:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Iwona Winiarska <iwona.winiarska@intel.com>,
        openbmc@lists.ozlabs.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [RFC PATCH] hwmon: (peci/cputemp) Number cores as seen by host
 system
Message-ID: <20230210184511.GA3670524@roeck-us.net>
References: <20230209011632.32668-1-zev@bewilderbeest.net>
 <20230209175001.GA667937@roeck-us.net>
 <Y+WMcCukyTvPcN2F@hatter.bewilderbeest.net>
 <97485a97-08c4-917b-1b8d-8102a8575a58@roeck-us.net>
 <Y+WieWyU+055eEom@hatter.bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+WieWyU+055eEom@hatter.bewilderbeest.net>
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 05:48:41PM -0800, Zev Weiss wrote:
> On Thu, Feb 09, 2023 at 04:26:47PM PST, Guenter Roeck wrote:
> > On 2/9/23 16:14, Zev Weiss wrote:
> > > On Thu, Feb 09, 2023 at 09:50:01AM PST, Guenter Roeck wrote:
> > > > On Wed, Feb 08, 2023 at 05:16:32PM -0800, Zev Weiss wrote:
> > > > > While porting OpenBMC to a new platform with a Xeon Gold 6314U CPU
> > > > > (Ice Lake, 32 cores), I discovered that the core numbering used by the
> > > > > PECI interface appears to correspond to the cores that are present in
> > > > > the physical silicon, rather than those that are actually enabled and
> > > > > usable by the host OS (i.e. it includes cores that the chip was
> > > > > manufactured with but later had fused off).
> > > > > 
> > > > > Thus far the cputemp driver has transparently exposed that numbering
> > > > > to userspace in its 'tempX_label' sysfs files, making the core numbers
> > > > > it reported not align with the core numbering used by the host system,
> > > > > which seems like an unfortunate source of confusion.
> > > > > 
> > > > > We can instead use a separate counter to label the cores in a
> > > > > contiguous fashion (0 through numcores-1) so that the core numbering
> > > > > reported by the PECI cputemp driver matches the numbering seen by the
> > > > > host.
> > > > > 
> > > > 
> > > > I don't really have an opinion if this change is desirable or not.
> > > > I suspect one could argue either way. I'l definitely want to see
> > > > feedback from others. Any comments or thoughts, anyone ?
> > > > 
> > > 
> > > Agreed, I'd definitely like to get some input from Intel folks on this.
> > > 
> > > Though since I realize my initial email didn't quite explain this explicitly, I should probably clarify with an example how weird the numbering can get with the existing code -- on the 32-core CPU I'm working with at the moment, the tempX_label files produce the following core numbers:
> > > 
> > >     Core 0
> > >     Core 1
> > >     Core 2
> > >     Core 3
> > >     Core 4
> > >     Core 5
> > >     Core 6
> > >     Core 7
> > >     Core 8
> > >     Core 9
> > >     Core 11
> > >     Core 12
> > >     Core 13
> > >     Core 14
> > >     Core 15
> > >     Core 18
> > >     Core 20
> > >     Core 22
> > >     Core 23
> > >     Core 24
> > >     Core 26
> > >     Core 27
> > >     Core 28
> > >     Core 29
> > >     Core 30
> > >     Core 31
> > >     Core 33
> > >     Core 34
> > >     Core 35
> > >     Core 36
> > >     Core 38
> > >     Core 39
> > > 
> > > i.e. it's not just a different permutation of the expected core numbers, we end up with gaps (e.g. the nonexistence of core 10), and core numbers well in excess of the number of cores the processor really "has" (e.g. number 39) -- all of which seems like a rather confusing thing to see in your BMC's sensor readings.
> > > 
> > 
> > Sure, but what do you see with /proc/cpuinfo and with coretemp
> > on the host ? It might be even more confusing if the core numbers
> > reported by the peci driver don't match the core numbers provided
> > by other tools.
> > 
> 
> The host sees them numbered as the usual 0-31 you'd generally expect, and
> assigned to those cores in the same increasing order -- hence the patch
> bringing the two into alignment with each other.  Currently only cores 0
> through 9 match up between the two, and the rest are off by somewhere
> between one and eight.
> 

Hmm, interesting. It is not sequential on my large system (Intel(R) Xeon(R)
Gold 6154). I also know for sure that core IDs on Intel server CPUs are
typically not sequential. The processor number is sequential, but the core
ID isn't. On my system, the output from the "sensors" command (that is,
from the coretemp driver) matches the non-sequential core IDs from
/proc/cpuinfo, which is exactly how I would expect it to be.

Guenter

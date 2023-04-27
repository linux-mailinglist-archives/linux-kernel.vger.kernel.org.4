Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E7A6F01E2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbjD0Hht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbjD0Hhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:37:47 -0400
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709F010CE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equiv.tech;
        h=from:subject:references:mime-version:content-type:in-reply-to:to:cc:
        content-transfer-encoding:cc:content-type:from:subject:to;
        s=org; bh=HJ3ETqPadb7zUTID7tP1U9AwKITVOi9X0oV/h6wnoSo=;
        b=uptKegTmRlxsYzrx+9oJn0Az6iDbGnsQiVZZ29fgprqKYWAgCFVPHnhiIiExFNk8l8N2
        xSUzf8NzDMUv25leThxNllGV5iRAkl3+1NGauNep1rPfpJaRVM9PfVlXV8WeeyAofaZ6sS
        RKXcH3fZ8Js02sdGutBCLCuNhv7oJa9lI=
Received: by filterdrecv-5848969764-pz6sb with SMTP id filterdrecv-5848969764-pz6sb-1-644A2648-6
        2023-04-27 07:37:44.16317308 +0000 UTC m=+152153.380604064
Received: from localhost (unknown)
        by geopod-ismtpd-3 (SG) with ESMTP
        id Dj5W3I_3RIewIlJRj5gQrw
        Thu, 27 Apr 2023 07:37:43.976 +0000 (UTC)
Date:   Thu, 27 Apr 2023 07:37:44 +0000 (UTC)
From:   James Seo <james@equiv.tech>
Subject: Re: [PATCH v3] hwmon: add HP WMI Sensors driver
Message-ID: <ZEomR842t6QrahyO@equiv.tech>
References: <20230424100459.41672-1-james@equiv.tech>
 <cd81a7d6-4b81-f074-1f28-6d1b5300b937@gmx.de>
 <ZEkkLggFLCGlvq8f@equiv.tech>
 <30339393-0ba2-9788-6ad8-98c89afc6994@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30339393-0ba2-9788-6ad8-98c89afc6994@gmx.de>
X-SG-EID: =?us-ascii?Q?1X41iaRO4wVP+tFXGLuxpQ0yxxMDhGIesR5UcsYKVengQKgidLJSXwOMZlPQwP?=
 =?us-ascii?Q?Ws8SOh1Mhvy+aML+f3d=2FS7ziskCfXzIzt9Z3SfQ?=
 =?us-ascii?Q?dtno+5xENtBaNbUdyeC0nzzETKiFnRLsLddkgG6?=
 =?us-ascii?Q?nHGIHM=2FkNY1=2FENI9=2FiMhHLxNtVtGZNS776WeRQE?=
 =?us-ascii?Q?cn3S7JoFAHmxU2NoMPXxDg7JQh4esq=2FvHRKA+9O?=
 =?us-ascii?Q?unPGpDo61aY9qXSxYL0oY=2Fe2pvgTFui4m71J6j?=
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Entity-ID: Y+qgTyM7KJvXcwsg19bS4g==
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 09:35:33PM +0200, Armin Wolf wrote:
> Am 26.04.23 um 15:16 schrieb James Seo:
> 
>> On Mon, Apr 24, 2023 at 11:13:36PM +0200, Armin Wolf wrote:
>>> Am 24.04.23 um 12:05 schrieb James Seo:
>>> 
>>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, pevents++) {
>>> Hi,
>>> 
>>> the WMI driver core already knows how many instances of a given WMI object are available.
>>> Unfortunately, this information is currently unavailable to drivers. Would it be convenient
>>> for you to access this information? I could try to implement such a function if needed.
>>> 
>>>> +	for (i = 0; i < HP_WMI_MAX_INSTANCES; i++, info++) {
>>> Same as above.
>>> 
>> Hello,
>> 
>> Having the WMI object instance count wouldn't make much difference to
>> me for now. The driver has to iterate through all instances during
>> init anyway. If I were forced to accommodate 50+ sensors, I'd rewrite
>> some things and I think I'd want such a function then, but I picked
>> the current arbitrary limit of 32 because even that seems unlikely.
>> 
>> So, maybe don't worry about it unless you want to. Or am I missing
>> something?
>> 
> Hi,
> 
> i already have a experimental patch available which adds such a function.
> If you could test this patch to see if it works, then i could submit it upstream
> where other drivers could profit from being able to know the number of
> WMI object instances.
> 

Both your proposed functions worked as expected.

> Your driver could also profit from such a function, as it could optimize the amount
> of memory allocated to store WMI object data.

I suppose I might as well. I assume I'm supposed to wait until your
new functions are merged before making changes that rely on them?

> The current instance discovery algorithm
> (using a for-loop and break on error) also has a potential issue: when a single WMI call
> fails for some reason (ACPI error, ...), all following WMI instances are being ignored.
> 

This is the intended behavior for now, on the assumption that a real
ACPI failure probably indicates that the system has bigger problems.
I do have vague plans to make the driver more tolerant of failure to
retrieve or validate instances, but haven't decided anything yet.

Regards,

James

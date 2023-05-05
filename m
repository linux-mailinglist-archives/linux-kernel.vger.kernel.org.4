Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA396F83A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjEENP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjEENPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:15:25 -0400
Received: from m228-4.mailgun.net (m228-4.mailgun.net [159.135.228.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE911F4A2
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 06:15:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=equiv.tech; q=dns/txt;
 s=mx; t=1683292520; x=1683299720; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Subject: Cc: To: To: From: From: Date:
 Sender: Sender; bh=WDYF6zI6A8OgkexxWkY88lLpFyBLDctri05ND1Dd0Zc=;
 b=fXtkMs064kya+6RpMb5Rst1QCs6BuPvpidmKVW0At3pFf/nDn0L21SbJbhssNVPX7aGUHXQMZOKxfqsPwnFSkeJGFU1w68OAsdL6p6Mj8wBXyHLgRDDk070jTTmFfBdhxRv9XRgrLFl0YRog5cPH5QWsbY9HLLhrSm7Qi7SbnC2l1ZvIEOZel/jJxwTN0EMohY5lCCNItjtxI8o2UEwir9j+0VaD/BOKSPPqJ0BVBff/WjTpk9m1tBAtULZ1FxZ0LFUu12TSn2LPh3KCXwsvDFCdhPiqtzPW3mdpT0K2nOV+FZuKf7tbR1DXegT78cQGamMAd6VO2FgH5DUnoE1Rng==
X-Mailgun-Sending-Ip: 159.135.228.4
X-Mailgun-Sid: WyI4ZWI3MiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI5M2Q1YWIiXQ==
Received: from mail.equiv.tech (equiv.tech [142.93.28.83]) by 897f46a039a2 with SMTP id
 645501688290b6a11e251403 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 May 2023 13:15:19 GMT
Sender: james@equiv.tech
Date:   Fri, 5 May 2023 06:15:19 -0700
From:   James Seo <james@equiv.tech>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/11] hwmon: (core) Rename last parameter of
 devm_hwmon_register_with_info()
Message-ID: <ZFUBZyG5eoz2TpZX@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-3-james@equiv.tech>
 <ff6efe53-2173-1372-a1ca-c0928cf8a160@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff6efe53-2173-1372-a1ca-c0928cf8a160@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 08:29:57AM -0700, Guenter Roeck wrote:
> Please please please no such changes. I don't want to have to deal with
> patch wars just because people believe variables should have other names.
> 
> Such changes add zero value unless one counts wasted review time as a "value".
> 
> Guenter
>

Hello,

Of course arbitrarily changing variable names is pointless. But this
patch fulfills the intent of 848ba0a2f20dc121a3ef5272a24641d2bd963d8b,
which makes this change for devm_hwmon_device_register_with_info() in
hwmon-kernel-api.txt and in hwmon.h - but not in hwmon.c. The same
commit makes the same change for hwmon_device_register_with_info() in
all three files, so it obviously should have been in tree already.

The other reason for this patch is that for the purpose of generating
function documentation from kerneldocs, it is not feasible to call
this parameter "extra_groups" in the kerneldoc and still call it
"groups" in the function itself. Doing so results in the lines
"const struct attribute_group **groups / undescribed" and no mention
of "extra_groups" in the generated document. Leaving things as is, so
that [devm_]hwmon_device_register_with_info() have different names
for this parameter, is potentially confusing and more noticeable to
to the eye than I would like once rendered.

Is this good enough to proceed? And as a subsystem maintainer, is
there anything else, specifically or in general, that you would like
to see addressed?

James


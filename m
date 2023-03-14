Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E2A6B93F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCNMgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjCNMgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:36:37 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3625B1167D;
        Tue, 14 Mar 2023 05:36:01 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PbXyb3Z7Rz4BKJN;
        Tue, 14 Mar 2023 14:34:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678797255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0oXi3GbdgC4Xa97QZcLIcbFIExHW5G4jF2m3rS3sI0=;
        b=lrZ30EIk6GrgolI9lySea54l2HKM79BmDe2WQFODFgQ+8C27b++yc8A5/Y/6l3jUsPqmRd
        tjKqPZ8JrRbIXXzskVSrlJFPbaWIZPS3ZO6zC4j91ds7GrnWttGwUmPm21iAKGHVsaJ5Fq
        YCl9NiLULCSeT0vct07aVbpqh1RUxO8wYcEUcVCmKPhzve2FzXxvVZWPrEs3WQPrcFSj2V
        lX2mhra9KfT0NKTZfbnYElTj4vS9u2DPX7To0xB0xhCTajHOb1std0aIMJbOiSKBLFilpD
        28TKu3kvhq0/oauzOcJANxXwbULaqDs1WlqDU4k3ZCGQjqR6Z2aZc0QWNsC5eg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678797255; a=rsa-sha256;
        cv=none;
        b=tGLcoQVXFccKydtNg60HuOBTP3QLkYqZftCXpnj4lHPS8FRt1o2jMj9sqAc84GRMEe5GF5
        yWy9RlAOMRXE+kT/b9q0hmSQEH60I1AZSu9aMMDKQaHg4SaDR/rHdjYnMjBWC6LUXvPmmo
        HX8RSPbDI1w4fh3Bu0zBGGIqTDho6D8HUhe6eaiztooPtJNDx8oZ3JtP4ZxrKVUu8VuCDp
        HOAIQtSJO0M/qZ5a0pV8UH/BXUwZ64U5ysu4yjakAmwkwuwd2sV+t/qLJHOo6k4XM1YYL7
        k3kB6OzybDmWKBDZRB6qRkfi9ATOAo8Oo9AX7CuEdduAE0WPPoC8X7p03F1pDA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678797255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0oXi3GbdgC4Xa97QZcLIcbFIExHW5G4jF2m3rS3sI0=;
        b=pDcFH0kKzgZmrLGgLUtMpeKfPTPzd7rdfSpTEsSTaX21VPz/FXUcP+AroactPtxRHZtEtF
        fCpIftqDv0rg1GOGYE5p0MFrxtXv9nQx3xVD/bhT/sF+dTnnbeieOA1Iblelg4qKX483OT
        sbA188Y3WWi7ZqJlDegxl/Fr8mK8c3RSaWm5inx0glk8NReUIZRPlJROPEmKojKayj94Qd
        UwyMhqOEeSngbfxAqyLOj7vnOmVn7iwB7/2+dPEq6otxengCpCPA5mK08FMz9JadnA+Dni
        sL0IsWLuRg6mliwOiQ/mqpl0pTCDQPvSMHKfRrjw91kcXlKYmKipVcBKhyWueQ==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A8669634C92;
        Tue, 14 Mar 2023 14:33:13 +0200 (EET)
Date:   Tue, 14 Mar 2023 14:33:13 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Robert Mader <robert.mader@collabora.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-kernel@vger.kernel.org, nicholas@rothemail.net,
        javierm@redhat.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v2] media: i2c: imx258: Parse and register properties
Message-ID: <ZBBpiUnKnRGTVPkZ@valkosipuli.retiisi.eu>
References: <20230104122337.123055-1-robert.mader@collabora.com>
 <20230104141159.e2klapbpenslxqbx@uno.localdomain>
 <e55766f0-5090-abb5-dbd7-58230153a8ce@collabora.com>
 <Y7WieRzn4p9NCwsg@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7WieRzn4p9NCwsg@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 03:59:53PM +0000, Sakari Ailus wrote:
> Hi Robert,
> 
> On Wed, Jan 04, 2023 at 03:14:50PM +0100, Robert Mader wrote:
> > On 04.01.23 15:11, Jacopo Mondi wrote:
> > > Hi Robert
> > > 
> > > On Wed, Jan 04, 2023 at 01:23:37PM +0100, Robert Mader wrote:
> > > > Analogous to e.g. the imx219. This enables propagating
> > > > V4L2_CID_CAMERA_ORIENTATION and V4L2_CID_CAMERA_SENSOR_ROTATION
> > > > values.
> > > > The motivation is to allow libcamera detect these values from the
> > > > device tree and propagate them further to e.g. Pipewire.
> > > > 
> > > > While at it, reserve space for 3 additional controls even if
> > > > v4l2_ctrl_new_fwnode_properties() can only register 2 of
> > > > them, to fix the existing implementation which reserve space for 8
> > > > controls but actually registers 9.
> > > > 
> > > > Changes in v2:
> > > >   - Reserve 11 instead of 10 controls
> > > >   - Change order of variable declaration
> > > >   - Slightly extend description
> > > This part should go below, after ---, as it shouldn't be part of the commit
> > > message
> > > 
> > > The patch looks good
> > > 
> > > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > Thanks! And ops, right, make sense. Should I spin a v3 for that or is it
> > simple enough to fix when pulling?
> 
> I can fix it while applying the patch.

No need for line breaks after period, just let your editor to break them
before 74 or so.

-- 
Sakari Ailus

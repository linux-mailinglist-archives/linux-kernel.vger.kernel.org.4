Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0B600369
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJPVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 17:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 17:03:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02B367B7;
        Sun, 16 Oct 2022 14:03:43 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8387AE65;
        Sun, 16 Oct 2022 23:03:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1665954220;
        bh=/HjB+raKBthocv/QhAd0ZHFd1QaretPzH2sxa49Rnm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHQswEjbNdQK+pIeuX/gPUDU6UkSWamMHeVO69fBmy9ka8tdq0WY4Bh1p9070Pt2K
         zIUAm28hoSgNMriJl7oGHFfLk16rZTUzjm8xELgK+g8GgPzdRKkz94FkiD9URRysI+
         y/0GtnFDio77gnEmEy37hAjxZeTnmQNv4OJkWfOQ=
Date:   Mon, 17 Oct 2022 00:03:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Prabhakar <prabhakar.csengg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 4/5] media: i2c: ov5645: Return zero for s_stream(0)
Message-ID: <Y0xxlTP53dwx8VD+@pendragon.ideasonboard.com>
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <Y0pSYfw+VDxXv85b@pendragon.ideasonboard.com>
 <Y0snkMEp9WqGtzom@paasikivi.fi.intel.com>
 <Y0tA4cZBdwCOkaOs@pendragon.ideasonboard.com>
 <Y0xnXM+Iw5OkdKj6@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0xnXM+Iw5OkdKj6@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Sun, Oct 16, 2022 at 08:19:40PM +0000, Sakari Ailus wrote:
> On Sun, Oct 16, 2022 at 02:23:13AM +0300, Laurent Pinchart wrote:
> > On Sat, Oct 15, 2022 at 09:35:12PM +0000, Sakari Ailus wrote:
> > > On Sat, Oct 15, 2022 at 09:25:37AM +0300, Laurent Pinchart wrote:
> > > > On Fri, Oct 14, 2022 at 07:34:58PM +0100, Prabhakar wrote:
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > 
> > > > > Always return zero while stopping the stream as the caller will ignore the
> > > > > return value.
> > > > > 
> > > > > This patch drops checking the return value of ov5645_write_reg() and
> > > > > continues further in the code path while stopping stream. The user anyway
> > > > > gets an error message in case ov5645_write_reg() fails.
> > > > 
> > > > Continuing all the way to pm_runtime_put() is fine, but I don't think
> > > > the function should return 0. It's not up to the driver to decide if a
> > > > failure would be useful to signal to the caller or not.
> > > 
> > > If the function returns an error when disabling streaming, what is the
> > > expected power state of the device after this?
> > 
> > That's up to us to decide :-)
> > 
> > > The contract between the caller and the callee is that the state is not
> > > changed if there is an error.
> > 
> > For most APIs, but that's not universal.
> > 
> > > This is a special case as very few callers
> > > check the return value for streamoff operation and those that do generally
> > > just print something. I've never seen a caller trying to prevent streaming
> > > off in this case, for instance.
> > 
> > I think the stream off call should proceed and try to power off the
> > device even if an error occurs along the way, i.e. it shouldn't return
> > upon the first detected error.
> > 
> > > Of course we could document that streaming off always counts as succeeded
> > > (e.g. decreasing device's runtime PM usage_count) while it could return an
> > > informational error code. But I wonder if anyone would ever benefit from
> > > that somehow. :-)
> > 
> > I think it could be useful to propagate errors up to inform the user
> > that something wrong happened. That would involve fixing lots of drivers
> > along the call chain though, so there's no urgency for the ov5645 to do
> > so, but isn't it better to propagate the error code instead of hiding
> > the issue ?
> 
> I also don't think hiding the issue would be the best thing to do, but that
> wouldn't likely be a big problem either.
> 
> How about printing a warning in the wrapper while returning zero to the
> original caller? This would keep the API intact while still leaving a trace
> on something failing. Of course the driver is also free to print whatever
> messages it likes.

While I think error propagation could be more useful in the long run,
printing a message in the wrapper is a good idea. I like centralized
error handling, it has a tendency to go wrong when left to individual
drivers.

-- 
Regards,

Laurent Pinchart

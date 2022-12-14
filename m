Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08C164C2C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 04:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiLND3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 22:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiLND3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:29:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E008222BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:29:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v8so20760461edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 19:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7V81I7/6cXuMLmxZ37PeqznBsJ4nPakQoFmc2FnuMBY=;
        b=QPwDFNK4iHik4Qj1VBQSba9paFPp0BZHz5RpWnwBvrz86c95+2CR5cHbCvi1qdqL/c
         tzt+SMCEV6bZOdnU6m5DeVeNMj1DWGbiaxbmLuNaGvD3IDGdYVlUmLYRZz8IPM3T3SE1
         VrK87+UCUn8KMGAGDT/ts1oXftw0UOhW9R3LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V81I7/6cXuMLmxZ37PeqznBsJ4nPakQoFmc2FnuMBY=;
        b=XJXfNZbpAdFiBaPeV3gen07Rmh0qz4vuxOeUiL499wOiRSA7nPYP2imgAZSMQsD8J2
         EMi95oQAEhTQfsAy2qxQ53drXlVbiyk0jpUVqDG9T/y7b0VFeW1FyhJk2uigxRgHfZg8
         yCmUI/9wXd4/IRWg98BklPqfUlFn6bgabirPoUcHanF0bQ/O9B+LLbEyxgJzGFHDz+B6
         RodpDfC3yor2eUY0pfJrr6iwJEObARH2SYjCcv495n5tzjQs8ZRTFBg4ASJpwGwAjUIG
         2mTdT43cLrrXXlaWM/MBnGjuK66oeQKS5raxWq9Q0tsoKY7U4moG4UBVjrrbdtTlt0wG
         H7OQ==
X-Gm-Message-State: ANoB5pnlxsZg5drh5rwEm+lRt7BrygWhKFzcLDSc1ZpV0tN68CgoCNxw
        DvFESJi9SXQlhTCOFam4gq6b7TeekZekIw7ZV9UKzg==
X-Google-Smtp-Source: AA0mqf6NJ7kZBR7dO+a1toZM2wE1mcdtnIK6g+JQwRdRrwtRYA+9LzbuHPLcsbRkWouspBifS/uIsy0uHOb9EBy0MTE=
X-Received: by 2002:a05:6402:1397:b0:467:78f2:d81f with SMTP id
 b23-20020a056402139700b0046778f2d81fmr66824025edv.88.1670988558697; Tue, 13
 Dec 2022 19:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20221103091243.96036-1-allen.chen@ite.com.tw> <20221103091243.96036-3-allen.chen@ite.com.tw>
 <CAEXTbpdLMzTP20v0RJFjFb1JyQK+AcXJDUNYnaNb5y67+V_S3g@mail.gmail.com>
In-Reply-To: <CAEXTbpdLMzTP20v0RJFjFb1JyQK+AcXJDUNYnaNb5y67+V_S3g@mail.gmail.com>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Wed, 14 Dec 2022 11:29:07 +0800
Message-ID: <CAEXTbpfBkKwS_ubYxfXceYJL4qwL2kAECGBapSv0+XwHSCeH2g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: add it6505 driver to read data-lanes
 and link-frequencies from dt
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

Pin-yen


Pin-yen

On Mon, Nov 21, 2022 at 1:39 PM Pin-yen Lin <treapking@chromium.org> wrote:
>
> Hi all,
> Friendly ping on this patch.
>
> Regards,
> Pin-yen
>
> On Thu, Nov 3, 2022 at 5:13 PM allen <allen.chen@ite.com.tw> wrote:
> >
> > From: allen chen <allen.chen@ite.com.tw>
> >
> > Add driver to read data-lanes and link-frequencies from dt property to
> > restrict output bandwidth.
> >
> > Signed-off-by: Allen chen <allen.chen@ite.com.tw>
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/ite-it6505.c | 80 +++++++++++++++++++++++++++--
> >  1 file changed, 77 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> > index a4302492cf8df..ed4536cde3140 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -437,6 +437,8 @@ struct it6505 {
> >         bool powered;
> >         bool hpd_state;
> >         u32 afe_setting;
> > +       u32 max_dpi_pixel_clock;
> > +       u32 max_lane_count;
> >         enum hdcp_state hdcp_status;
> >         struct delayed_work hdcp_work;
> >         struct work_struct hdcp_wait_ksv_list;
> > @@ -1476,7 +1478,8 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
> >         it6505->lane_count = link->num_lanes;
> >         DRM_DEV_DEBUG_DRIVER(dev, "Sink support %d lanes training",
> >                              it6505->lane_count);
> > -       it6505->lane_count = min_t(int, it6505->lane_count, MAX_LANE_COUNT);
> > +       it6505->lane_count = min_t(int, it6505->lane_count,
> > +                                  it6505->max_lane_count);
> >
> >         it6505->branch_device = drm_dp_is_branch(it6505->dpcd);
> >         DRM_DEV_DEBUG_DRIVER(dev, "Sink %sbranch device",
> > @@ -2912,7 +2915,7 @@ it6505_bridge_mode_valid(struct drm_bridge *bridge,
> >         if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> >                 return MODE_NO_INTERLACE;
> >
> > -       if (mode->clock > DPI_PIXEL_CLK_MAX)
> > +       if (mode->clock > it6505->max_dpi_pixel_clock)
> >                 return MODE_CLOCK_HIGH;
> >
> >         it6505->video_info.clock = mode->clock;
> > @@ -3099,10 +3102,32 @@ static int it6505_init_pdata(struct it6505 *it6505)
> >         return 0;
> >  }
> >
> > +static int it6505_get_data_lanes_count(const struct device_node *endpoint,
> > +                                      const unsigned int min,
> > +                                      const unsigned int max)
> > +{
> > +       int ret;
> > +
> > +       ret = of_property_count_u32_elems(endpoint, "data-lanes");
> > +       if (ret < 0)
> > +               return ret;
> > +
> > +       if (ret < min || ret > max)
> > +               return -EINVAL;
> > +
> > +       return ret;
> > +}
> > +
> >  static void it6505_parse_dt(struct it6505 *it6505)
> >  {
> >         struct device *dev = &it6505->client->dev;
> > +       struct device_node *np = dev->of_node, *ep = NULL;
> > +       int len;
> > +       u64 link_frequencies;
> > +       u32 data_lanes[4];
> >         u32 *afe_setting = &it6505->afe_setting;
> > +       u32 *max_lane_count = &it6505->max_lane_count;
> > +       u32 *max_dpi_pixel_clock = &it6505->max_dpi_pixel_clock;
> >
> >         it6505->lane_swap_disabled =
> >                 device_property_read_bool(dev, "no-laneswap");
> > @@ -3118,7 +3143,56 @@ static void it6505_parse_dt(struct it6505 *it6505)
> >         } else {
> >                 *afe_setting = 0;
> >         }
> > -       DRM_DEV_DEBUG_DRIVER(dev, "using afe_setting: %d", *afe_setting);
> > +
> > +       ep = of_graph_get_endpoint_by_regs(np, 1, 0);
> > +       of_node_put(ep);
> > +
> > +       if (ep) {
> > +               len = it6505_get_data_lanes_count(ep, 1, 4);
> > +
> > +               if (len > 0 && len != 3) {
> > +                       of_property_read_u32_array(ep, "data-lanes",
> > +                                                  data_lanes, len);
> > +                       *max_lane_count = len;
> > +               } else {
> > +                       *max_lane_count = MAX_LANE_COUNT;
> > +                       dev_err(dev, "error data-lanes, use default");
> > +               }
> > +       } else {
> > +               *max_lane_count = MAX_LANE_COUNT;
> > +               dev_err(dev, "error endpoint, use default");
> > +       }
> > +
> > +       ep = of_graph_get_endpoint_by_regs(np, 0, 0);
> > +       of_node_put(ep);
> > +
> > +       if (ep) {
> > +               len = of_property_read_variable_u64_array(ep,
> > +                                                         "link-frequencies",
> > +                                                         &link_frequencies, 0,
> > +                                                         1);
> > +               if (len >= 0) {
> > +                       do_div(link_frequencies, 1000);
> > +                       if (link_frequencies > 297000) {
> > +                               dev_err(dev,
> > +                                       "max pixel clock error, use default");
> > +                               *max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
> > +                       } else {
> > +                               *max_dpi_pixel_clock = link_frequencies;
> > +                       }
> > +               } else {
> > +                       dev_err(dev, "error link frequencies, use default");
> > +                       *max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
> > +               }
> > +       } else {
> > +               dev_err(dev, "error endpoint, use default");
> > +               *max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
> > +       }
> > +
> > +       DRM_DEV_DEBUG_DRIVER(dev, "using afe_setting: %u, max_lane_count: %u",
> > +                            it6505->afe_setting, it6505->max_lane_count);
> > +       DRM_DEV_DEBUG_DRIVER(dev, "using max_dpi_pixel_clock: %u kHz",
> > +                            it6505->max_dpi_pixel_clock);
> >  }
> >
> >  static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
> > --
> > 2.25.1
> >

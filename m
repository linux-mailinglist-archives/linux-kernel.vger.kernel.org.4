Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1553679240
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 08:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjAXHq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 02:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjAXHq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 02:46:56 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C3F3D912
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:46:53 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qx13so36605467ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6g19/O4k5AwG/SXLw3kDzRcWbvy7LZU8yJW74odXy5E=;
        b=HVef/kjrTpFoFyiY1MmMmgpapa8gv9v1k/kcKhEG05OxvgATNlTU+soQKjbtKfe+MA
         Q1rnZcf6SUX9ETiybl9WqCQhDVQzUBy52QcONub4EHWVRuyPoOjB5Ox6vMhyKanK2Mr5
         Z5DaSIYDGBNcvBrHMsO0Vi9g+/WzEHxFnGZ/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g19/O4k5AwG/SXLw3kDzRcWbvy7LZU8yJW74odXy5E=;
        b=cTTg+F2xP+tJH3DNgr2sSeLfYeRtOVOMzlHrVh7+hubFkZBAwYVCyXnWLu0tZt7xhG
         TVz+zq1NnsrO5LAEVwdo06IIL7t2I4T5FHjw6Arg3XV5qoehY6lod7I11uj+6qGlF/HM
         IgjTcXBLc4jjtRfPZnmfvAbumEij0J+NP73/v/fJ4gBFnjCucKwjFs8e/8Bm/FzExkXx
         F1Jxu+Il3JMvIGhAAyYR4oFEu/OIO2g0OHLo9UNIk7wW5bv1iOydCkF2hx2LFU+ZOpv0
         FD5idZl0EDxAMRZsJDWKGVxe6ErcU2VnyBqjuGJtpf7YSPVB31Zc82G+ooYhaAZEg57k
         Krow==
X-Gm-Message-State: AFqh2koc6FzqCwL3i8iBZ9+rEuUAPnnMfTGm+yXyvXWrlE7QorPwL191
        Ycpj993hnxmJm3FpQPHw5qBt4XW7Ka0MwPvV6L4=
X-Google-Smtp-Source: AMrXdXvcEpRCFAnJlT0s6krj+KWm0nKpNhi0WDmMMsL1iLqHymNnmqS8nuSRGhG+OVcU/OVw5IV/fQ==
X-Received: by 2002:a17:906:89a4:b0:852:dc8d:3a01 with SMTP id gg36-20020a17090689a400b00852dc8d3a01mr26563608ejc.55.1674546411974;
        Mon, 23 Jan 2023 23:46:51 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id cf5-20020a170906b2c500b0084d37cc06fesm524582ejb.94.2023.01.23.23.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 23:46:50 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12186386wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 23:46:50 -0800 (PST)
X-Received: by 2002:a05:600c:2247:b0:3d9:9de9:da92 with SMTP id
 a7-20020a05600c224700b003d99de9da92mr1487835wmm.50.1674546409620; Mon, 23 Jan
 2023 23:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20230124061521.v2.1.I6c0a089123fdf143f94ef4cca8677639031856cf@changeid>
 <CABXOdTeFw_puhp5t=UUWLwrtqaoLo9ys6Z8r9Gd4HXZ3te8jdQ@mail.gmail.com>
In-Reply-To: <CABXOdTeFw_puhp5t=UUWLwrtqaoLo9ys6Z8r9Gd4HXZ3te8jdQ@mail.gmail.com>
From:   Victor Ding <victording@chromium.org>
Date:   Tue, 24 Jan 2023 18:46:13 +1100
X-Gmail-Original-Message-ID: <CANqTbdY97fMCrw3w=dFwpYFNqib5zV4MQ-PnKOwFsR4WZEA8jA@mail.gmail.com>
Message-ID: <CANqTbdY97fMCrw3w=dFwpYFNqib5zV4MQ-PnKOwFsR4WZEA8jA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: allow deferred probe
 of switch handles
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        dustin@howett.net, lee.jones@linaro.org, bleung@chromium.org,
        dnojiri@chromium.org, sebastian.reichel@collabora.com,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        gustavoars@kernel.org, groeck@chromium.org,
        enric.balletbo@collabora.com, tinghan.shen@mediatek.com,
        heikki.krogerus@linux.intel.com, tzungbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:57 PM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Jan 23, 2023 at 10:16 PM Victor Ding <victording@chromium.org> wrote:
> >
> > `fwnode_typec_{retimer,mux,switch}_get()` could return `-EPROBE_DEFER`,
> > which is called from `cros_typec_get_switch_handles`. When this happens,
> > it does not indicate absence of switches; instead, it only hints that
> > probing of switches should occur at a later time.
> >
> > Progagate `-EPROBE_DEFER` to upper layer logic so that they can re-try
> > probing switches as a better time.
> >
> > Signed-off-by: Victor Ding <victording@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Coverted switch-block to nested if-blocks.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 26 ++++++++++++++++---------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 59de4ce01fab..580f3bdf091c 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -145,31 +145,37 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> >                                          struct fwnode_handle *fwnode,
> >                                          struct device *dev)
> >  {
> > +       int ret = 0;
> > +
> >         port->mux = fwnode_typec_mux_get(fwnode, NULL);
> >         if (IS_ERR(port->mux)) {
> > -               dev_dbg(dev, "Mux handle not found.\n");
> > +               ret = PTR_ERR(port->mux);
> > +               dev_dbg(dev, "Mux handle not found: %d.\n", ret);
> >                 goto mux_err;
> >         }
> >
> >         port->retimer = fwnode_typec_retimer_get(fwnode);
> >         if (IS_ERR(port->retimer)) {
> > -               dev_dbg(dev, "Retimer handle not found.\n");
> > +               ret = PTR_ERR(port->retimer);
> > +               dev_dbg(dev, "Retimer handle not found: %d.\n", ret);
> >                 goto retimer_sw_err;
> >         }
> >
> >         port->ori_sw = fwnode_typec_switch_get(fwnode);
> >         if (IS_ERR(port->ori_sw)) {
> > -               dev_dbg(dev, "Orientation switch handle not found.\n");
> > +               ret = PTR_ERR(port->ori_sw);
> > +               dev_dbg(dev, "Orientation switch handle not found: %d\n", ret);
> >                 goto ori_sw_err;
> >         }
> >
> >         port->role_sw = fwnode_usb_role_switch_get(fwnode);
> >         if (IS_ERR(port->role_sw)) {
> > -               dev_dbg(dev, "USB role switch handle not found.\n");
> > +               ret = PTR_ERR(port->role_sw);
> > +               dev_dbg(dev, "USB role switch handle not found: %d\n", ret);
> >                 goto role_sw_err;
> >         }
> >
> > -       return 0;
> > +       return ret;
> >
>
> This change is pointless.
Sure, I'll revert this line to `return 0` in the next revision.
>
> Guenter
>
> >  role_sw_err:
> >         typec_switch_put(port->ori_sw);
> > @@ -181,7 +187,7 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> >         typec_mux_put(port->mux);
> >         port->mux = NULL;
> >  mux_err:
> > -       return -ENODEV;
> > +       return ret;
> >  }
> >
> >  static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
> > @@ -423,9 +429,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >                 }
> >
> >                 ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> > -               if (ret)
> > -                       dev_dbg(dev, "No switch control for port %d\n",
> > -                               port_num);
> > +               if (ret) {
> > +                       dev_dbg(dev, "No switch control for port %d, err: %d\n", port_num, ret);
> > +                       if (ret == -EPROBE_DEFER)
> > +                               goto unregister_ports;
> > +               }
> >
> >                 ret = cros_typec_register_port_altmodes(typec, port_num);
> >                 if (ret) {
> > --
> > 2.39.1.405.gd4c25cc71f-goog
> >

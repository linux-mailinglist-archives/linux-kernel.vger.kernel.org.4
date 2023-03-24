Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23D56C85F7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 20:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCXT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjCXT1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 15:27:30 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9201DBAA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t15so2843769wrz.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 12:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679686046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A76mQMLCXjYaVOvcsZRi/XfbCpgyGK8ELYNqRDF4dnY=;
        b=BGlDYDhoCSHvCE30sxCZJ330CsatpMec4rqSDHE1b4iNuDgzdZP3RcITGzQLdhSQE1
         0N3Yz4BMfkOggoOZZEfuE48SBNrNXGe5M58Yo36TE3i0jUzVIoBUrgNYgI0hYrQog6Yc
         0ccSEqEMB5Z2pmlPWflgH7nYkrYlTvygQ/xE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679686046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A76mQMLCXjYaVOvcsZRi/XfbCpgyGK8ELYNqRDF4dnY=;
        b=mfQw8/ut6WJK30hG5/29ujPX1P4sK5FodP5DmRVF7Db9xJpeYcrWaxjrKvIYvq023L
         d1o70/N+2XLrV2bJ+B2RK3mOz4kliyeR5UziMgvwAXQVR/A4tk8BGWrYWlQewgMDz/Qt
         83tau+V53LPYMMSzThyFIDoWONkViIClh0pk4gFzcP56FiNps84XNIJlNat1T8yYPagJ
         TU4NIHfcqoAkkb4pYcJYY6Fe92rg22+fcRhwUGeTmiQP4pvEyO63igc5FJrmtwbCJlLE
         GUfHLCdT6ac2pqG600VDh7FdHhcNyBRIIS3GweK67UGVLsaJh10dlnciyApAsjwtMpzn
         B+RA==
X-Gm-Message-State: AAQBX9eXphcBJyge61VWo9C3LyrDigP+i0X0Gvg9L46psg9BF8Q5jA7X
        GwcwKAVbbBQ7km5t6o8VX9bK7gbuBDKLw/VddK/+Sw==
X-Google-Smtp-Source: AKy350aA0OrVbBXXikGt1TrNwIXDxKvzGrW8p1JqkcKi/TrZpSty/ja8lUFG73jSGVmL/obLAm6bK/QBzKB/s35FXu4=
X-Received: by 2002:adf:f8cf:0:b0:2d3:3db2:bbae with SMTP id
 f15-20020adff8cf000000b002d33db2bbaemr804498wrq.5.1679686046094; Fri, 24 Mar
 2023 12:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230118193015.911074-1-markyacoub@google.com>
 <20230118193015.911074-7-markyacoub@google.com> <MWHPR11MB1741FB33E933A3285B7DC88DE3BA9@MWHPR11MB1741.namprd11.prod.outlook.com>
 <MWHPR11MB1741D833E10227E8BA1CEE03E3879@MWHPR11MB1741.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB1741D833E10227E8BA1CEE03E3879@MWHPR11MB1741.namprd11.prod.outlook.com>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Fri, 24 Mar 2023 15:27:15 -0400
Message-ID: <CAJUqKUqhHmvD0K7OzrFKPeBBxprXgLVw1-L-vpNAAS7u4CxNoA@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] drm/i915/hdcp: Retain hdcp_capable return codes
To:     "Kandpal, Suraj" <suraj.kandpal@intel.com>
Cc:     "quic_khsieh@quicinc.com" <quic_khsieh@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "quic_sbillaka@quicinc.com" <quic_sbillaka@quicinc.com>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "Souza, Jose" <jose.souza@intel.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "hbh25y@gmail.com" <hbh25y@gmail.com>,
        "Vasut, Marek" <marex@denx.de>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "abhinavk@codeaurora.org" <abhinavk@codeaurora.org>,
        "javierm@redhat.com" <javierm@redhat.com>,
        "Murthy, Arun R" <arun.r.murthy@intel.com>,
        "Lisovskiy, Stanislav" <stanislav.lisovskiy@intel.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
        "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
        "Nikula, Jani" <jani.nikula@intel.com>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "quic_abhinavk@quicinc.com" <quic_abhinavk@quicinc.com>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "Sharma, Swati2" <swati2.sharma@intel.com>,
        "Navare, Manasi D" <manasi.d.navare@intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "Modem, Bhanuprakash" <bhanuprakash.modem@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 3:18=E2=80=AFAM Kandpal, Suraj <suraj.kandpal@intel=
.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Kandpal, Suraj
> > Sent: Friday, March 10, 2023 1:55 PM
> > To: Mark Yacoub <markyacoub@chromium.org>; quic_khsieh@quicinc.com;
> > linux-arm-msm@vger.kernel.org; dri-devel@lists.freedesktop.org;
> > freedreno@lists.freedesktop.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; intel-gfx@lists.freedesktop.org
> > Cc: quic_sbillaka@quicinc.com; konrad.dybcio@somainline.org; Souza, Jos=
e
> > <jose.souza@intel.com>; bjorn.andersson@linaro.org;
> > krzysztof.kozlowski+dt@linaro.org; hbh25y@gmail.com; Vasut, Marek
> > <marex@denx.de>; Dixit, Ashutosh <ashutosh.dixit@intel.com>;
> > sean@poorly.run; abhinavk@codeaurora.org; javierm@redhat.com; Murthy,
> > Arun R <arun.r.murthy@intel.com>; Lisovskiy, Stanislav
> > <Stanislav.Lisovskiy@intel.com>; agross@kernel.org;
> > quic_jesszhan@quicinc.com; Nautiyal, Ankit K <ankit.k.nautiyal@intel.co=
m>;
> > Nikula, Jani <jani.nikula@intel.com>; De Marchi, Lucas
> > <lucas.demarchi@intel.com>; quic_abhinavk@quicinc.com;
> > swboyd@chromium.org; robh+dt@kernel.org;
> > christophe.jaillet@wanadoo.fr; maxime@cerno.tech; Vivi, Rodrigo
> > <rodrigo.vivi@intel.com>; johan+linaro@kernel.org;
> > tvrtko.ursulin@linux.intel.com; andersson@kernel.org;
> > dianders@chromium.org; Sharma, Swati2 <swati2.sharma@intel.com>;
> > Navare, Manasi D <manasi.d.navare@intel.com>; tzimmermann@suse.de;
> > Modem, Bhanuprakash <Bhanuprakash.Modem@intel.com>;
> > dmitry.baryshkov@linaro.org; seanpaul@chromium.org
> > Subject: RE: [PATCH v6 06/10] drm/i915/hdcp: Retain hdcp_capable return
> > codes
> >
> > > Subject: [PATCH v6 06/10] drm/i915/hdcp: Retain hdcp_capable return
> > > codes
> > >
> > > From: Sean Paul <seanpaul@chromium.org>
> > >
> > > The shim functions return error codes, but they are discarded in
> > > intel_hdcp.c. This patch plumbs the return codes through so they are
> > > properly handled.
> > >
> > > Acked-by: Jani Nikula <jani.nikula@intel.com>
> > > Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> > > Link:
> > > https://patchwork.freedesktop.org/patch/msgid/20210913175747.47456-7-
> > > sean@poorly.run #v1
> > > Link:
> > > https://patchwork.freedesktop.org/patch/msgid/20210915203834.1439-7-
> > > sean@poorly.run #v2
> > > Link:
> > > https://patchwork.freedesktop.org/patch/msgid/20211001151145.55916-7-
> > > sean@poorly.run #v3
> > > Link:
> > >
> > https://patchwork.freedesktop.org/patch/msgid/20211105030434.2828845-
> > > 7-sean@poorly.run #v4
> > > Link:
> > >
> > https://patchwork.freedesktop.org/patch/msgid/20220411204741.1074308-
> > > 7-sean@poorly.run #v5
> > >
> > > Changes in v2:
> > > -None
> > > Changes in v3:
> > > -None
> > > Changes in v4:
> > > -None
> > > Changes in v5:
> > > -None
> > > Changes in v6:
> > > -Rebased
> > >
> > > ---
> > >  .../drm/i915/display/intel_display_debugfs.c  |  9 +++-
> > >  drivers/gpu/drm/i915/display/intel_hdcp.c     | 51 ++++++++++-------=
--
> > >  drivers/gpu/drm/i915/display/intel_hdcp.h     |  4 +-
> > >  3 files changed, 37 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > > b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > > index 7c7253a2541c..13a4153bb76e 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
> > > @@ -492,6 +492,7 @@ static void intel_panel_info(struct seq_file *m,
> > > static void intel_hdcp_info(struct seq_file *m,
> > >                         struct intel_connector *intel_connector)  {
> > > +   int ret;
> > >     bool hdcp_cap, hdcp2_cap;
> > >
> > >     if (!intel_connector->hdcp.shim) {
> > > @@ -499,8 +500,12 @@ static void intel_hdcp_info(struct seq_file *m,
> > >             goto out;
> > >     }
> > >
> > > -   hdcp_cap =3D intel_hdcp_capable(intel_connector);
> > > -   hdcp2_cap =3D intel_hdcp2_capable(intel_connector);
> > > +   ret =3D intel_hdcp_capable(intel_connector, &hdcp_cap);
> > > +   if (ret)
> > > +           hdcp_cap =3D false;
> > > +   ret =3D intel_hdcp2_capable(intel_connector, &hdcp2_cap);
> > > +   if (ret)
> > > +           hdcp2_cap =3D false;
> > >
> >
> > This does not seem to be adding value here as this error which you refe=
rred
> > to as being ignored is used both in case of hdmi and dp is being to det=
ermine
> > if hdcp_cap or hdcp2 cap is true or false which you basically reiterate=
 here too
> > check the intel_dp_hdcp2_capable and intel_hdmi_hdcp2_capable .
> > this change in itself can be removed.
> >
> > Regards,
> > Suraj Kandpal
> >
Hey Suraj, what we're trying to do here is to have a distinction
between 2 things:
1. were we able to check of the capability or not. like did the
connection work well
2. if the check went well, what capability were were able to read
We may or may not need both info. But since we moved to common DRM, it
might be best keep the distinction and each driver can handle it as it
sees fit.
> > >     if (hdcp_cap)
> > >             seq_puts(m, "HDCP1.4 ");
> > > diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c
> > > b/drivers/gpu/drm/i915/display/intel_hdcp.c
> > > index 0a20bc41be55..61a862ae1f28 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
> > > @@ -177,50 +177,49 @@ int intel_hdcp_read_valid_bksv(struct
> > > intel_digital_port *dig_port,  }
> > >
> > >  /* Is HDCP1.4 capable on Platform and Sink */ -bool
> > > intel_hdcp_capable(struct intel_connector *connector)
> > > +int intel_hdcp_capable(struct intel_connector *connector, bool
> > > +*capable)
> > >  {
> > >     struct intel_digital_port *dig_port =3D
> > > intel_attached_dig_port(connector);
> > >     const struct intel_hdcp_shim *shim =3D connector->hdcp.shim;
> > > -   bool capable =3D false;
> > >     u8 bksv[5];
> > >
> > > +   *capable =3D false;
> > > +
> > >     if (!shim)
> > > -           return capable;
> > > +           return 0;
> > >
> > > -   if (shim->hdcp_capable) {
> > > -           shim->hdcp_capable(dig_port, &capable);
> > > -   } else {
> > > -           if (!intel_hdcp_read_valid_bksv(dig_port, shim, bksv))
> > > -                   capable =3D true;
> > > -   }
> > > +   if (shim->hdcp_capable)
> > > +           return shim->hdcp_capable(dig_port, capable);
> > > +
> > > +   if (!intel_hdcp_read_valid_bksv(dig_port, shim, bksv))
> > > +           *capable =3D true;
> > >
> > > -   return capable;
> > > +   return 0;
> > >  }
> > >
> > >  /* Is HDCP2.2 capable on Platform and Sink */ -bool
> > > intel_hdcp2_capable(struct intel_connector *connector)
> > > +int intel_hdcp2_capable(struct intel_connector *connector, bool
> > > +*capable)
> > >  {
> > >     struct intel_digital_port *dig_port =3D
> > > intel_attached_dig_port(connector);
> > >     struct drm_i915_private *dev_priv =3D to_i915(connector->base.dev=
);
> > >     struct intel_hdcp *hdcp =3D &connector->hdcp;
> > > -   bool capable =3D false;
> > > +
> > > +   *capable =3D false;
> > >
> > >     /* I915 support for HDCP2.2 */
> > >     if (!hdcp->hdcp2_supported)
> > > -           return false;
> > > +           return 0;
> > >
> > >     /* MEI interface is solid */
> > >     mutex_lock(&dev_priv->display.hdcp.comp_mutex);
> > >     if (!dev_priv->display.hdcp.comp_added ||  !dev_priv-
> > > >display.hdcp.master) {
> > >             mutex_unlock(&dev_priv->display.hdcp.comp_mutex);
> > > -           return false;
> > > +           return 0;
> > >     }
> > >     mutex_unlock(&dev_priv->display.hdcp.comp_mutex);
> > >
> > >     /* Sink's capability for HDCP2.2 */
> > > -   hdcp->shim->hdcp_2_2_capable(dig_port, &capable);
> > > -
> > > -   return capable;
> > > +   return hdcp->shim->hdcp_2_2_capable(dig_port, capable);
> > >  }
> > >
> > >  static bool intel_hdcp_in_use(struct drm_i915_private *dev_priv, @@ =
-
> > > 2355,6 +2354,7 @@ int intel_hdcp_enable(struct intel_connector
> > > *connector,
> > >     struct intel_digital_port *dig_port =3D
> > > intel_attached_dig_port(connector);
> > >     struct intel_hdcp *hdcp =3D &connector->hdcp;
> > >     unsigned long check_link_interval =3D
> > DRM_HDCP_CHECK_PERIOD_MS;
> > > +   bool capable;
> > >     int ret =3D -EINVAL;
> > >
> > >     if (!hdcp->shim)
> > > @@ -2373,21 +2373,27 @@ int intel_hdcp_enable(struct intel_connector
> > > *connector,
> > >      * Considering that HDCP2.2 is more secure than HDCP1.4, If the
> > > setup
> > >      * is capable of HDCP2.2, it is preferred to use HDCP2.2.
> > >      */
> > > -   if (intel_hdcp2_capable(connector)) {
> > > +   ret =3D intel_hdcp2_capable(connector, &capable);
> > > +   if (capable) {
> > >             ret =3D _intel_hdcp2_enable(connector);
> > > -           if (!ret)
> > > +           if (!ret) {
> > >                     check_link_interval =3D
> > > DRM_HDCP2_CHECK_PERIOD_MS;
> > > +                   goto out;
> > > +           }
>
> HI,
> Just noticed another changed here if any error is returned with intel_hdc=
2_capable
> You directly jump to out which will stop us from enabling hdcp 1.4 we sho=
uld check
> for hdcp 1.4 capability even if hdcp 2.2 capability is returned with an e=
rror one other
> reason I don't think the handling of error codes are adding value here.
>
> Regards,
> Suraj Kandpal
Hey Suraj - the goto happens if we know that the device is hdcp2
capable. If it's capable, we do enable it. If we have no error
returned, that's when we skip hdcp1.4
otherwise, if it's not capable, or the enable returned with an error
code, we don't goto out but move on to try on hdcp 1.4
Thanks!
> > >     }
> > >
> > >     /*
> > >      * When HDCP2.2 fails and Content Type is not Type1, HDCP1.4 will
> > >      * be attempted.
> > >      */
> > > -   if (ret && intel_hdcp_capable(connector) &&
> > > -       hdcp->content_type !=3D DRM_MODE_HDCP_CONTENT_TYPE1) {
> > > +   ret =3D intel_hdcp_capable(connector, &capable);
> > > +   if (ret)
> > > +           goto out;
> > > +
> > > +   if (capable && hdcp->content_type !=3D
> > > DRM_MODE_HDCP_CONTENT_TYPE1)
> > >             ret =3D _intel_hdcp_enable(connector);
> > > -   }
> > >
> > > +out:
> > >     if (!ret) {
> > >             schedule_delayed_work(&hdcp->check_work,
> > > check_link_interval);
> > >             intel_hdcp_update_value(connector,
> > > @@ -2395,7 +2401,6 @@ int intel_hdcp_enable(struct intel_connector
> > > *connector,
> > >                                     true);
> > >     }
> > >
> > > -out:
> > >     mutex_unlock(&dig_port->hdcp_mutex);
> > >     mutex_unlock(&hdcp->mutex);
> > >     return ret;
> > > diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.h
> > > b/drivers/gpu/drm/i915/display/intel_hdcp.h
> > > index 7c5fd84a7b65..f06f6e5a2b1a 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_hdcp.h
> > > +++ b/drivers/gpu/drm/i915/display/intel_hdcp.h
> > > @@ -33,8 +33,8 @@ void intel_hdcp_update_pipe(struct
> > > intel_atomic_state *state,
> > >                         const struct intel_crtc_state *crtc_state,
> > >                         const struct drm_connector_state *conn_state)=
;
> > bool
> > > is_hdcp_supported(struct drm_i915_private *dev_priv, enum port port);
> > > -bool intel_hdcp_capable(struct intel_connector *connector); -bool
> > > intel_hdcp2_capable(struct intel_connector *connector);
> > > +int intel_hdcp_capable(struct intel_connector *connector, bool
> > > +*capable); int intel_hdcp2_capable(struct intel_connector *connector=
,
> > > +bool *capable);
> > >  void intel_hdcp_component_init(struct drm_i915_private *dev_priv);
> > > void intel_hdcp_component_fini(struct drm_i915_private *dev_priv);
> > > void intel_hdcp_cleanup(struct intel_connector *connector);
> > > --
> > > 2.39.0.246.g2a6d74b583-goog
>

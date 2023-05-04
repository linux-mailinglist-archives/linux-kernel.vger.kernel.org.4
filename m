Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9C46F6867
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjEDJh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEDJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:37:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2703646BF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 02:37:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50a0aa56230so17967a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683193069; x=1685785069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yOLNDqazeahZxG2aIuuo/lgveXe646svu0Y0l8HlDlQ=;
        b=X2/HGY0+3cgVDw0fPOWm2QZ/5xFG7x0Y/ALy1dwU4oihyjCukbGC4tTdOgzyhkaaXa
         FI4qSDOrY0P5nD/8/mEim1WqfwQ+llYw2K+rYzz8bBPCr5hnPByS2+/84Kr16SyhXjgU
         EStehVSMcBvrVMwT4SZMF6Ug/UPPHPUlECGSe5lVY5QWill/003Ecni4pr33bNZKCxLD
         ZEFWU0MKbKGQioRD6sK8LjPcUYEmw28shSKqzdAJsZmL1/18dgF9xPDhEf5kyI4lFNoY
         m1skrdnpgzAEp3aqqcyTGsVUpYLlhreNwXyNl0rmoyklQA+v+sb5UfnRAlJf2HDymn9E
         p1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683193069; x=1685785069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOLNDqazeahZxG2aIuuo/lgveXe646svu0Y0l8HlDlQ=;
        b=VIIp89qGdCup6CZ47Q19fhR5++0u1sF7UTvdidrKFzFyPSxL+avmFc05Pw/g4RLNQN
         xiClVQ1VfSnrBt7f1eXqL/sDDimeSGlVmRZAnhmHH4NP5i3Le+44uz4tHpfRxCliRAGl
         lB4tV4DkRyVLSMyHfIx3rjjzbetV6NjREQOz0ha1XnAS8UHX8tYw3tqIO2rrOno0oA/f
         D33AD9JUYr+8xtDCKWUtThm016V09QXz3BedZXHTKct+dx2uU0ZlAWPwShLCaDbbPWae
         xEc0Rya9C3CfZLJO/OJ7V7NcbZfyf7gjCjKQ2sCKY6yeS8K1XDwYEoUmuVKZCuorYW9y
         CeBA==
X-Gm-Message-State: AC+VfDxg5bhvKvj1xSwcv/DarsF27KlLymAtlen6WAYZSS8ivRlm7EPM
        qXp9jcuV6Vckn05JCftP6yF9svrPQiIqIoPmapIAcg==
X-Google-Smtp-Source: ACHHUZ52cSDwsLXWq4FXSTipDtACE4m5EMW2yIlhFgZnab6+Qei2V4+t+iI83reangk56Kn5p5i5vjxK9dgwxG6yjO4=
X-Received: by 2002:a05:6402:1945:b0:502:368:66a8 with SMTP id
 f5-20020a056402194500b00502036866a8mr37433edz.1.1683193069242; Thu, 04 May
 2023 02:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230504092142.4190069-1-yixuanjiang@google.com>
In-Reply-To: <20230504092142.4190069-1-yixuanjiang@google.com>
From:   Yixuan Jiang <yixuanjiang@google.com>
Date:   Thu, 4 May 2023 17:37:38 +0800
Message-ID: <CAGJzVQFSbffFwjq6PtDw-Spxryf1A7L=jgUMJZ2_TabkUxGfFQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Fix and cleanup DPCM locking
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yixuanjiang <yixuanjiang@google.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=884=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:22=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Takashi Iwai <tiwai@suse.de>
>
> The existing locking for DPCM has several issues
> a) a confusing mix of card->mutex and card->pcm_mutex.
> b) a dpcm_lock spinlock added inconsistently and on paths that could
> be recursively taken. The use of irqsave/irqrestore was also overkill.
>
> The suggested model is:
>
> 1) The pcm_mutex is the top-most protection of BE links in the FE. The
> pcm_mutex is applied always on either the top PCM callbacks or the
> external call from DAPM, not taken in the internal functions.
>
> 2) the FE stream lock is taken in higher levels before invoking
> dpcm_be_dai_trigger()
>
> 3) when adding and deleting a BE, both the pcm_mutex and FE stream
> lock are taken.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [clarification of commit message by plbossart]
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Link: https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossa=
rt@linux.intel.com
> Cc: stable@vger.kernel.org # 5.15.x
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  include/sound/soc.h  |   2 -
>  sound/soc/soc-core.c |   1 -
>  sound/soc/soc-pcm.c  | 229 ++++++++++++++++++++++++++++---------------
>  3 files changed, 152 insertions(+), 80 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 8e6dd8a257c5..5872a8864f3b 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -893,8 +893,6 @@ struct snd_soc_card {
>         struct mutex pcm_mutex;
>         enum snd_soc_pcm_subclass pcm_subclass;
>
> -       spinlock_t dpcm_lock;
> -
>         int (*probe)(struct snd_soc_card *card);
>         int (*late_probe)(struct snd_soc_card *card);
>         int (*remove)(struct snd_soc_card *card);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 1b1749b920f4..a5b3ee69fb88 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card=
)
>         mutex_init(&card->mutex);
>         mutex_init(&card->dapm_mutex);
>         mutex_init(&card->pcm_mutex);
> -       spin_lock_init(&card->dpcm_lock);
>
>         return snd_soc_bind_card(card);
>  }
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 3b673477f621..07ad98934c7a 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -27,6 +27,31 @@
>  #include <sound/soc-link.h>
>  #include <sound/initval.h>
>
> +static inline void snd_soc_dpcm_mutex_lock(struct snd_soc_pcm_runtime *r=
td)
> +{
> +       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +}
> +
> +static inline void snd_soc_dpcm_mutex_unlock(struct snd_soc_pcm_runtime =
*rtd)
> +{
> +       mutex_unlock(&rtd->card->pcm_mutex);
> +}
> +
> +#define snd_soc_dpcm_mutex_assert_held(rtd) \
> +       lockdep_assert_held(&(rtd)->card->pcm_mutex)
> +
> +static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runti=
me *rtd,
> +                                               int stream)
> +{
> +       snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
> +}
> +
> +static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_run=
time *rtd,
> +                                                 int stream)
> +{
> +       snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream)=
);
> +}
> +
>  #define DPCM_MAX_BE_USERS      8
>
>  static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *r=
td)
> @@ -73,7 +98,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_runti=
me *fe,
>         struct snd_pcm_hw_params *params =3D &fe->dpcm[stream].hw_params;
>         struct snd_soc_dpcm *dpcm;
>         ssize_t offset =3D 0;
> -       unsigned long flags;
>
>         /* FE state */
>         offset +=3D scnprintf(buf + offset, size - offset,
> @@ -101,7 +125,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_run=
time *fe,
>                 goto out;
>         }
>
> -       spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>         for_each_dpcm_be(fe, stream, dpcm) {
>                 struct snd_soc_pcm_runtime *be =3D dpcm->be;
>                 params =3D &dpcm->hw_params;
> @@ -122,7 +145,6 @@ static ssize_t dpcm_show_state(struct snd_soc_pcm_run=
time *fe,
>                                            params_channels(params),
>                                            params_rate(params));
>         }
> -       spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>  out:
>         return offset;
>  }
> @@ -145,11 +167,13 @@ static ssize_t dpcm_state_read_file(struct file *fi=
le, char __user *user_buf,
>         if (!buf)
>                 return -ENOMEM;
>
> +       snd_soc_dpcm_mutex_lock(fe);
>         for_each_pcm_streams(stream)
>                 if (snd_soc_dai_stream_valid(asoc_rtd_to_cpu(fe, 0), stre=
am))
>                         offset +=3D dpcm_show_state(fe, stream,
>                                                   buf + offset,
>                                                   out_count - offset);
> +       snd_soc_dpcm_mutex_unlock(fe);
>
>         ret =3D simple_read_from_buffer(user_buf, count, ppos, buf, offse=
t);
>
> @@ -221,14 +245,14 @@ static void dpcm_set_fe_update_state(struct snd_soc=
_pcm_runtime *fe,
>         struct snd_pcm_substream *substream =3D
>                 snd_soc_dpcm_get_substream(fe, stream);
>
> -       snd_pcm_stream_lock_irq(substream);
> +       snd_soc_dpcm_stream_lock_irq(fe, stream);
>         if (state =3D=3D SND_SOC_DPCM_UPDATE_NO && fe->dpcm[stream].trigg=
er_pending) {
>                 dpcm_fe_dai_do_trigger(substream,
>                                        fe->dpcm[stream].trigger_pending -=
 1);
>                 fe->dpcm[stream].trigger_pending =3D 0;
>         }
>         fe->dpcm[stream].runtime_update =3D state;
> -       snd_pcm_stream_unlock_irq(substream);
> +       snd_soc_dpcm_stream_unlock_irq(fe, stream);
>  }
>
>  static void dpcm_set_be_update_state(struct snd_soc_pcm_runtime *be,
> @@ -256,7 +280,7 @@ void snd_soc_runtime_action(struct snd_soc_pcm_runtim=
e *rtd,
>         struct snd_soc_dai *dai;
>         int i;
>
> -       lockdep_assert_held(&rtd->card->pcm_mutex);
> +       snd_soc_dpcm_mutex_assert_held(rtd);
>
>         for_each_rtd_dais(rtd, i, dai)
>                 snd_soc_dai_action(dai, stream, action);
> @@ -309,6 +333,8 @@ int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime=
 *fe, int dir,
>  {
>         struct snd_soc_dpcm *dpcm;
>
> +       snd_soc_dpcm_mutex_assert_held(fe);
> +
>         for_each_dpcm_be(fe, dir, dpcm) {
>
>                 struct snd_soc_pcm_runtime *be =3D dpcm->be;
> @@ -646,14 +672,14 @@ static int soc_pcm_components_close(struct snd_pcm_=
substream *substream,
>         return ret;
>  }
>
> -static int soc_pcm_clean(struct snd_pcm_substream *substream, int rollba=
ck)
> +static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
> +                        struct snd_pcm_substream *substream, int rollbac=
k)
>  {
> -       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
>         struct snd_soc_component *component;
>         struct snd_soc_dai *dai;
>         int i;
>
> -       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +       snd_soc_dpcm_mutex_assert_held(rtd);
>
>         if (!rollback)
>                 snd_soc_runtime_deactivate(rtd, substream->stream);
> @@ -665,9 +691,6 @@ static int soc_pcm_clean(struct snd_pcm_substream *su=
bstream, int rollback)
>
>         soc_pcm_components_close(substream, rollback);
>
> -
> -       mutex_unlock(&rtd->card->pcm_mutex);
> -
>         snd_soc_pcm_component_pm_runtime_put(rtd, substream, rollback);
>
>         for_each_rtd_components(rtd, i, component)
> @@ -682,9 +705,21 @@ static int soc_pcm_clean(struct snd_pcm_substream *s=
ubstream, int rollback)
>   * freed here. The cpu DAI, codec DAI, machine and components are also
>   * shutdown.
>   */
> +static int __soc_pcm_close(struct snd_soc_pcm_runtime *rtd,
> +                          struct snd_pcm_substream *substream)
> +{
> +       return soc_pcm_clean(rtd, substream, 0);
> +}
> +
> +/* PCM close ops for non-DPCM streams */
>  static int soc_pcm_close(struct snd_pcm_substream *substream)
>  {
> -       return soc_pcm_clean(substream, 0);
> +       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> +
> +       snd_soc_dpcm_mutex_lock(rtd);
> +       soc_pcm_clean(rtd, substream, 0);
> +       snd_soc_dpcm_mutex_unlock(rtd);
> +       return 0;
>  }
>
>  static int soc_hw_sanity_check(struct snd_pcm_substream *substream)
> @@ -730,21 +765,21 @@ static int soc_hw_sanity_check(struct snd_pcm_subst=
ream *substream)
>   * then initialized and any private data can be allocated. This also cal=
ls
>   * startup for the cpu DAI, component, machine and codec DAI.
>   */
> -static int soc_pcm_open(struct snd_pcm_substream *substream)
> +static int __soc_pcm_open(struct snd_soc_pcm_runtime *rtd,
> +                         struct snd_pcm_substream *substream)
>  {
> -       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
>         struct snd_soc_component *component;
>         struct snd_soc_dai *dai;
>         int i, ret =3D 0;
>
> +       snd_soc_dpcm_mutex_assert_held(rtd);
> +
>         for_each_rtd_components(rtd, i, component)
>                 pinctrl_pm_select_default_state(component->dev);
>
>         ret =3D snd_soc_pcm_component_pm_runtime_get(rtd, substream);
>         if (ret < 0)
> -               goto pm_err;
> -
> -       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +               goto err;
>
>         ret =3D soc_pcm_components_open(substream);
>         if (ret < 0)
> @@ -786,16 +821,26 @@ static int soc_pcm_open(struct snd_pcm_substream *s=
ubstream)
>         snd_soc_runtime_activate(rtd, substream->stream);
>         ret =3D 0;
>  err:
> -       mutex_unlock(&rtd->card->pcm_mutex);
> -pm_err:
>         if (ret < 0) {
> -               soc_pcm_clean(substream, 1);
> +               soc_pcm_clean(rtd, substream, 1);
>                 dev_err(rtd->dev, "%s() failed (%d)", __func__, ret);
>         }
>
>         return ret;
>  }
>
> +/* PCM open ops for non-DPCM streams */
> +static int soc_pcm_open(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> +       int ret;
> +
> +       snd_soc_dpcm_mutex_lock(rtd);
> +       ret =3D __soc_pcm_open(rtd, substream);
> +       snd_soc_dpcm_mutex_unlock(rtd);
> +       return ret;
> +}
> +
>  static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *r=
td)
>  {
>         /*
> @@ -811,13 +856,13 @@ static void codec2codec_close_delayed_work(struct s=
nd_soc_pcm_runtime *rtd)
>   * rate, etc.  This function is non atomic and can be called multiple ti=
mes,
>   * it can refer to the runtime info.
>   */
> -static int soc_pcm_prepare(struct snd_pcm_substream *substream)
> +static int __soc_pcm_prepare(struct snd_soc_pcm_runtime *rtd,
> +                            struct snd_pcm_substream *substream)
>  {
> -       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
>         struct snd_soc_dai *dai;
>         int i, ret =3D 0;
>
> -       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +       snd_soc_dpcm_mutex_assert_held(rtd);
>
>         ret =3D snd_soc_link_prepare(substream);
>         if (ret < 0)
> @@ -845,14 +890,24 @@ static int soc_pcm_prepare(struct snd_pcm_substream=
 *substream)
>                 snd_soc_dai_digital_mute(dai, 0, substream->stream);
>
>  out:
> -       mutex_unlock(&rtd->card->pcm_mutex);
> -
>         if (ret < 0)
>                 dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, r=
et);
>
>         return ret;
>  }
>
> +/* PCM prepare ops for non-DPCM streams */
> +static int soc_pcm_prepare(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> +       int ret;
> +
> +       snd_soc_dpcm_mutex_lock(rtd);
> +       ret =3D __soc_pcm_prepare(rtd, substream);
> +       snd_soc_dpcm_mutex_unlock(rtd);
> +       return ret;
> +}
> +
>  static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
>                                        unsigned int mask)
>  {
> @@ -864,13 +919,13 @@ static void soc_pcm_codec_params_fixup(struct snd_p=
cm_hw_params *params,
>         interval->max =3D channels;
>  }
>
> -static int soc_pcm_hw_clean(struct snd_pcm_substream *substream, int rol=
lback)
> +static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
> +                           struct snd_pcm_substream *substream, int roll=
back)
>  {
> -       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
>         struct snd_soc_dai *dai;
>         int i;
>
> -       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +       snd_soc_dpcm_mutex_assert_held(rtd);
>
>         /* clear the corresponding DAIs parameters when going to be inact=
ive */
>         for_each_rtd_dais(rtd, i, dai) {
> @@ -900,16 +955,28 @@ static int soc_pcm_hw_clean(struct snd_pcm_substrea=
m *substream, int rollback)
>                 snd_soc_dai_hw_free(dai, substream, rollback);
>         }
>
> -       mutex_unlock(&rtd->card->pcm_mutex);
>         return 0;
>  }
>
>  /*
>   * Frees resources allocated by hw_params, can be called multiple times
>   */
> +static int __soc_pcm_hw_free(struct snd_soc_pcm_runtime *rtd,
> +                            struct snd_pcm_substream *substream)
> +{
> +       return soc_pcm_hw_clean(rtd, substream, 0);
> +}
> +
> +/* hw_free PCM ops for non-DPCM streams */
>  static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
>  {
> -       return soc_pcm_hw_clean(substream, 0);
> +       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> +       int ret;
> +
> +       snd_soc_dpcm_mutex_lock(rtd);
> +       ret =3D __soc_pcm_hw_free(rtd, substream);
> +       snd_soc_dpcm_mutex_unlock(rtd);
> +       return ret;
>  }
>
>  /*
> @@ -917,15 +984,15 @@ static int soc_pcm_hw_free(struct snd_pcm_substream=
 *substream)
>   * function can also be called multiple times and can allocate buffers
>   * (using snd_pcm_lib_* ). It's non-atomic.
>   */
> -static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> -                               struct snd_pcm_hw_params *params)
> +static int __soc_pcm_hw_params(struct snd_soc_pcm_runtime *rtd,
> +                              struct snd_pcm_substream *substream,
> +                              struct snd_pcm_hw_params *params)
>  {
> -       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
>         struct snd_soc_dai *cpu_dai;
>         struct snd_soc_dai *codec_dai;
>         int i, ret =3D 0;
>
> -       mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass)=
;
> +       snd_soc_dpcm_mutex_assert_held(rtd);
>
>         ret =3D soc_pcm_params_symmetry(substream, params);
>         if (ret)
> @@ -997,16 +1064,27 @@ static int soc_pcm_hw_params(struct snd_pcm_substr=
eam *substream,
>
>         ret =3D snd_soc_pcm_component_hw_params(substream, params);
>  out:
> -       mutex_unlock(&rtd->card->pcm_mutex);
> -
>         if (ret < 0) {
> -               soc_pcm_hw_clean(substream, 1);
> +               soc_pcm_hw_clean(rtd, substream, 1);
>                 dev_err(rtd->dev, "ASoC: %s() failed (%d)\n", __func__, r=
et);
>         }
>
>         return ret;
>  }
>
> +/* hw_params PCM ops for non-DPCM streams */
> +static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> +                            struct snd_pcm_hw_params *params)
> +{
> +       struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> +       int ret;
> +
> +       snd_soc_dpcm_mutex_lock(rtd);
> +       ret =3D __soc_pcm_hw_params(rtd, substream, params);
> +       snd_soc_dpcm_mutex_unlock(rtd);
> +       return ret;
> +}
> +
>  static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  {
>         struct snd_soc_pcm_runtime *rtd =3D asoc_substream_to_rtd(substre=
am);
> @@ -1124,7 +1202,8 @@ static int dpcm_be_connect(struct snd_soc_pcm_runti=
me *fe,
>                 struct snd_soc_pcm_runtime *be, int stream)
>  {
>         struct snd_soc_dpcm *dpcm;
> -       unsigned long flags;
> +
> +       snd_soc_dpcm_mutex_assert_held(fe);
>
>         /* only add new dpcms */
>         for_each_dpcm_be(fe, stream, dpcm) {
> @@ -1140,10 +1219,10 @@ static int dpcm_be_connect(struct snd_soc_pcm_run=
time *fe,
>         dpcm->fe =3D fe;
>         be->dpcm[stream].runtime =3D fe->dpcm[stream].runtime;
>         dpcm->state =3D SND_SOC_DPCM_LINK_STATE_NEW;
> -       spin_lock_irqsave(&fe->card->dpcm_lock, flags);
> +       snd_soc_dpcm_stream_lock_irq(fe, stream);
>         list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
>         list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
> -       spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
> +       snd_soc_dpcm_stream_unlock_irq(fe, stream);
>
>         dev_dbg(fe->dev, "connected new DPCM %s path %s %s %s\n",
>                         stream ? "capture" : "playback",  fe->dai_link->n=
ame,
> @@ -1188,8 +1267,10 @@ static void dpcm_be_reparent(struct snd_soc_pcm_ru=
ntime *fe,
>  void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
>  {
>         struct snd_soc_dpcm *dpcm, *d;
> -       unsigned long flags;
>
> +       snd_soc_dpcm_mutex_assert_held(fe);
> +
> +       snd_soc_dpcm_stream_lock_irq(fe, stream);
>         for_each_dpcm_be_safe(fe, stream, dpcm, d) {
>                 dev_dbg(fe->dev, "ASoC: BE %s disconnect check for %s\n",
>                                 stream ? "capture" : "playback",
> @@ -1207,12 +1288,11 @@ void dpcm_be_disconnect(struct snd_soc_pcm_runtim=
e *fe, int stream)
>
>                 dpcm_remove_debugfs_state(dpcm);
>
> -               spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>                 list_del(&dpcm->list_be);
>                 list_del(&dpcm->list_fe);
> -               spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>                 kfree(dpcm);
>         }
> +       snd_soc_dpcm_stream_unlock_irq(fe, stream);
>  }
>
>  /* get BE for DAI widget and stream */
> @@ -1426,12 +1506,9 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime =
*fe,
>  void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream=
)
>  {
>         struct snd_soc_dpcm *dpcm;
> -       unsigned long flags;
>
> -       spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>         for_each_dpcm_be(fe, stream, dpcm)
>                 dpcm_set_be_update_state(dpcm->be, stream, SND_SOC_DPCM_U=
PDATE_NO);
> -       spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>  }
>
>  void dpcm_be_dai_stop(struct snd_soc_pcm_runtime *fe, int stream,
> @@ -1467,12 +1544,12 @@ void dpcm_be_dai_stop(struct snd_soc_pcm_runtime =
*fe, int stream,
>                                 continue;
>
>                         if (be->dpcm[stream].state !=3D SND_SOC_DPCM_STAT=
E_HW_FREE) {
> -                               soc_pcm_hw_free(be_substream);
> +                               __soc_pcm_hw_free(be, be_substream);
>                                 be->dpcm[stream].state =3D SND_SOC_DPCM_S=
TATE_HW_FREE;
>                         }
>                 }
>
> -               soc_pcm_close(be_substream);
> +               __soc_pcm_close(be, be_substream);
>                 be_substream->runtime =3D NULL;
>                 be->dpcm[stream].state =3D SND_SOC_DPCM_STATE_CLOSE;
>         }
> @@ -1520,7 +1597,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime =
*fe, int stream)
>                         stream ? "capture" : "playback", be->dai_link->na=
me);
>
>                 be_substream->runtime =3D be->dpcm[stream].runtime;
> -               err =3D soc_pcm_open(be_substream);
> +               err =3D __soc_pcm_open(be, be_substream);
>                 if (err < 0) {
>                         be->dpcm[stream].users--;
>                         if (be->dpcm[stream].users < 0)
> @@ -1764,7 +1841,7 @@ static int dpcm_fe_dai_startup(struct snd_pcm_subst=
ream *fe_substream)
>         dev_dbg(fe->dev, "ASoC: open FE %s\n", fe->dai_link->name);
>
>         /* start the DAI frontend */
> -       ret =3D soc_pcm_open(fe_substream);
> +       ret =3D __soc_pcm_open(fe, fe_substream);
>         if (ret < 0)
>                 goto unwind;
>
> @@ -1795,6 +1872,8 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_subs=
tream *substream)
>         struct snd_soc_pcm_runtime *fe =3D asoc_substream_to_rtd(substrea=
m);
>         int stream =3D substream->stream;
>
> +       snd_soc_dpcm_mutex_assert_held(fe);
> +
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>
>         /* shutdown the BEs */
> @@ -1803,7 +1882,7 @@ static int dpcm_fe_dai_shutdown(struct snd_pcm_subs=
tream *substream)
>         dev_dbg(fe->dev, "ASoC: close FE %s\n", fe->dai_link->name);
>
>         /* now shutdown the frontend */
> -       soc_pcm_close(substream);
> +       __soc_pcm_close(fe, substream);
>
>         /* run the stream stop event */
>         dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
> @@ -1848,7 +1927,7 @@ void dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime=
 *fe, int stream)
>                 dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
>                         be->dai_link->name);
>
> -               soc_pcm_hw_free(be_substream);
> +               __soc_pcm_hw_free(be, be_substream);
>
>                 be->dpcm[stream].state =3D SND_SOC_DPCM_STATE_HW_FREE;
>         }
> @@ -1859,13 +1938,13 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_sub=
stream *substream)
>         struct snd_soc_pcm_runtime *fe =3D asoc_substream_to_rtd(substrea=
m);
>         int stream =3D substream->stream;
>
> -       mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       snd_soc_dpcm_mutex_lock(fe);
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>
>         dev_dbg(fe->dev, "ASoC: hw_free FE %s\n", fe->dai_link->name);
>
>         /* call hw_free on the frontend */
> -       soc_pcm_hw_free(substream);
> +       soc_pcm_hw_clean(fe, substream, 0);
>
>         /* only hw_params backends that are either sinks or sources
>          * to this frontend DAI */
> @@ -1874,7 +1953,7 @@ static int dpcm_fe_dai_hw_free(struct snd_pcm_subst=
ream *substream)
>         fe->dpcm[stream].state =3D SND_SOC_DPCM_STATE_HW_FREE;
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
>
> -       mutex_unlock(&fe->card->mutex);
> +       snd_soc_dpcm_mutex_unlock(fe);
>         return 0;
>  }
>
> @@ -1918,7 +1997,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtim=
e *fe, int stream)
>                 dev_dbg(be->dev, "ASoC: hw_params BE %s\n",
>                         be->dai_link->name);
>
> -               ret =3D soc_pcm_hw_params(be_substream, &dpcm->hw_params)=
;
> +               ret =3D __soc_pcm_hw_params(be, be_substream, &dpcm->hw_p=
arams);
>                 if (ret < 0)
>                         goto unwind;
>
> @@ -1948,7 +2027,7 @@ int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtim=
e *fe, int stream)
>                    (be->dpcm[stream].state !=3D SND_SOC_DPCM_STATE_STOP))
>                         continue;
>
> -               soc_pcm_hw_free(be_substream);
> +               __soc_pcm_hw_free(be, be_substream);
>         }
>
>         return ret;
> @@ -1960,7 +2039,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>         struct snd_soc_pcm_runtime *fe =3D asoc_substream_to_rtd(substrea=
m);
>         int ret, stream =3D substream->stream;
>
> -       mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       snd_soc_dpcm_mutex_lock(fe);
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_FE);
>
>         memcpy(&fe->dpcm[stream].hw_params, params,
> @@ -1974,7 +2053,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>                         params_channels(params), params_format(params));
>
>         /* call hw_params on the frontend */
> -       ret =3D soc_pcm_hw_params(substream, params);
> +       ret =3D __soc_pcm_hw_params(fe, substream, params);
>         if (ret < 0)
>                 dpcm_be_dai_hw_free(fe, stream);
>         else
> @@ -1982,7 +2061,7 @@ static int dpcm_fe_dai_hw_params(struct snd_pcm_sub=
stream *substream,
>
>  out:
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
> -       mutex_unlock(&fe->card->mutex);
> +       snd_soc_dpcm_mutex_unlock(fe);
>
>         if (ret < 0)
>                 dev_err(fe->dev, "ASoC: %s failed (%d)\n", __func__, ret)=
;
> @@ -2253,7 +2332,7 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime =
*fe, int stream)
>                 dev_dbg(be->dev, "ASoC: prepare BE %s\n",
>                         be->dai_link->name);
>
> -               ret =3D soc_pcm_prepare(be_substream);
> +               ret =3D __soc_pcm_prepare(be, be_substream);
>                 if (ret < 0)
>                         break;
>
> @@ -2271,7 +2350,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_subst=
ream *substream)
>         struct snd_soc_pcm_runtime *fe =3D asoc_substream_to_rtd(substrea=
m);
>         int stream =3D substream->stream, ret =3D 0;
>
> -       mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       snd_soc_dpcm_mutex_lock(fe);
>
>         dev_dbg(fe->dev, "ASoC: prepare FE %s\n", fe->dai_link->name);
>
> @@ -2290,7 +2369,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_subst=
ream *substream)
>                 goto out;
>
>         /* call prepare on the frontend */
> -       ret =3D soc_pcm_prepare(substream);
> +       ret =3D __soc_pcm_prepare(fe, substream);
>         if (ret < 0)
>                 goto out;
>
> @@ -2298,7 +2377,7 @@ static int dpcm_fe_dai_prepare(struct snd_pcm_subst=
ream *substream)
>
>  out:
>         dpcm_set_fe_update_state(fe, stream, SND_SOC_DPCM_UPDATE_NO);
> -       mutex_unlock(&fe->card->mutex);
> +       snd_soc_dpcm_mutex_unlock(fe);
>
>         if (ret < 0)
>                 dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, re=
t);
> @@ -2349,7 +2428,6 @@ static int dpcm_run_update_startup(struct snd_soc_p=
cm_runtime *fe, int stream)
>         struct snd_soc_dpcm *dpcm;
>         enum snd_soc_dpcm_trigger trigger =3D fe->dai_link->trigger[strea=
m];
>         int ret =3D 0;
> -       unsigned long flags;
>
>         dev_dbg(fe->dev, "ASoC: runtime %s open on FE %s\n",
>                         stream ? "capture" : "playback", fe->dai_link->na=
me);
> @@ -2418,7 +2496,6 @@ static int dpcm_run_update_startup(struct snd_soc_p=
cm_runtime *fe, int stream)
>         dpcm_be_dai_shutdown(fe, stream);
>  disconnect:
>         /* disconnect any pending BEs */
> -       spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>         for_each_dpcm_be(fe, stream, dpcm) {
>                 struct snd_soc_pcm_runtime *be =3D dpcm->be;
>
> @@ -2430,7 +2507,6 @@ static int dpcm_run_update_startup(struct snd_soc_p=
cm_runtime *fe, int stream)
>                         be->dpcm[stream].state =3D=3D SND_SOC_DPCM_STATE_=
NEW)
>                                 dpcm->state =3D SND_SOC_DPCM_LINK_STATE_F=
REE;
>         }
> -       spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>
>         if (ret < 0)
>                 dev_err(fe->dev, "ASoC: %s() failed (%d)\n", __func__, re=
t);
> @@ -2505,7 +2581,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card=
 *card)
>         struct snd_soc_pcm_runtime *fe;
>         int ret =3D 0;
>
> -       mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       mutex_lock_nested(&card->pcm_mutex, card->pcm_subclass);
>         /* shutdown all old paths first */
>         for_each_card_rtds(card, fe) {
>                 ret =3D soc_dpcm_fe_runtime_update(fe, 0);
> @@ -2521,7 +2597,7 @@ int snd_soc_dpcm_runtime_update(struct snd_soc_card=
 *card)
>         }
>
>  out:
> -       mutex_unlock(&card->mutex);
> +       mutex_unlock(&card->pcm_mutex);
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_dpcm_runtime_update);
> @@ -2532,6 +2608,8 @@ static void dpcm_fe_dai_cleanup(struct snd_pcm_subs=
tream *fe_substream)
>         struct snd_soc_dpcm *dpcm;
>         int stream =3D fe_substream->stream;
>
> +       snd_soc_dpcm_mutex_assert_held(fe);
> +
>         /* mark FE's links ready to prune */
>         for_each_dpcm_be(fe, stream, dpcm)
>                 dpcm->state =3D SND_SOC_DPCM_LINK_STATE_FREE;
> @@ -2546,12 +2624,12 @@ static int dpcm_fe_dai_close(struct snd_pcm_subst=
ream *fe_substream)
>         struct snd_soc_pcm_runtime *fe =3D asoc_substream_to_rtd(fe_subst=
ream);
>         int ret;
>
> -       mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       snd_soc_dpcm_mutex_lock(fe);
>         ret =3D dpcm_fe_dai_shutdown(fe_substream);
>
>         dpcm_fe_dai_cleanup(fe_substream);
>
> -       mutex_unlock(&fe->card->mutex);
> +       snd_soc_dpcm_mutex_unlock(fe);
>         return ret;
>  }
>
> @@ -2562,7 +2640,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substrea=
m *fe_substream)
>         int ret;
>         int stream =3D fe_substream->stream;
>
> -       mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
> +       snd_soc_dpcm_mutex_lock(fe);
>         fe->dpcm[stream].runtime =3D fe_substream->runtime;
>
>         ret =3D dpcm_path_get(fe, stream, &list);
> @@ -2579,7 +2657,7 @@ static int dpcm_fe_dai_open(struct snd_pcm_substrea=
m *fe_substream)
>         dpcm_clear_pending_state(fe, stream);
>         dpcm_path_put(&list);
>  open_end:
> -       mutex_unlock(&fe->card->mutex);
> +       snd_soc_dpcm_mutex_unlock(fe);
>         return ret;
>  }
>
> @@ -2840,10 +2918,8 @@ static int snd_soc_dpcm_check_state(struct snd_soc=
_pcm_runtime *fe,
>         struct snd_soc_dpcm *dpcm;
>         int state;
>         int ret =3D 1;
> -       unsigned long flags;
>         int i;
>
> -       spin_lock_irqsave(&fe->card->dpcm_lock, flags);
>         for_each_dpcm_fe(be, stream, dpcm) {
>
>                 if (dpcm->fe =3D=3D fe)
> @@ -2857,7 +2933,6 @@ static int snd_soc_dpcm_check_state(struct snd_soc_=
pcm_runtime *fe,
>                         }
>                 }
>         }
> -       spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
>
>         /* it's safe to do this BE DAI */
>         return ret;
> --
> 2.40.1.495.gc816e09b53d-goog
>

Hi,
 There is deadlock issue on 5.15 branch after compress offload playback sto=
p.

[  212.063445] sysrq: Show Blocked State
[  212.064964] Call trace:
[  212.064974] __switch_to+0x244/0x454
[  212.065075] __schedule+0x5fc/0xbdc
[  212.065092] schedule+0x154/0x258
[  212.065103] schedule_preempt_disabled+0x30/0x50
[  212.065115] __mutex_lock+0x36c/0x794
[  212.065135] __mutex_lock_slowpath+0x1c/0x2c
[  212.065145] soc_pcm_hw_clean+0x6c/0x364       //Requset pcm_mutex,
deadlock due to AA lock.  ( in soc-pcm.c )
[  212.065177] dpcm_be_dai_hw_free+0x20c/0x304   //Still holding
pcm_mutex                      ( in soc-pcm.c )
[  212.065188] soc_compr_free_fe+0x130/0x448     //hold pcm_mutex, it
will release the lock before call dpcm_be_dai_hw_free if revert the
patch ( in soc-compress.c )
[  212.065230] snd_compr_free+0xac/0x148
[  212.065316] __fput+0x104/0x438
[  212.065347] ____fput+0x18/0x28
[  212.065409] task_work_run+0x144/0x1f8
[  212.065474] do_notify_resume+0x1d24/0x27b0
[  212.065518] el0_svc+0x68/0xc4
[  212.065601] el0t_64_sync_handler+0x8c/0xfc
[ 212.065610] el0t_64_sync+0x1b0/0x1b4

In 5.15,
Related to patch
https://lore.kernel.org/all/016401d90ac4$7b6848c0$7238da40$@samsung.com/
and missing current patch
https://lore.kernel.org/r/20211207173745.15850-4-pierre-louis.bossart@linux=
.intel.com
cause the deadlock.

Could this patch backport to 5.15 branch?

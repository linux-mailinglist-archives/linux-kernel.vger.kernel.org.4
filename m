Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD946AF6EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 21:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjCGUsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 15:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCGUsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 15:48:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C6C3D902
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 12:48:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F64361578
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 20:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B19C433EF;
        Tue,  7 Mar 2023 20:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678222081;
        bh=/9hRjHkdO8S5xRlJr6uZkgy1JY1JFyYBLxygyfehtY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XjZ5hrpyxhIe3tzJH+DkWY7Xq4F9MRm0OXOjpdnpEKbAQkfZL2u6rqDuF9cwCwtqc
         m9UvvvrouHS0UBgfV94RaN9WTzAEzAPbtx1KWkc7c1VFSLi+ruPmWCIEGaFpfxp5Wy
         ETUBGeynHnO22UhFYnNAfA4PGaRHondtYpY5zu32gPFMgvcDnf6D3IsS1IVEsE082r
         6t5EbOYYRCgWdxP1tOQF4zjmeCLqLPGYsJzE+bRNnG1T0kv4wYt6fODujtmRV34CG/
         upLvWoH4jF3glBz8sN5Q+8W8mnm2AkLd/f63qBiolSqnF1lGd4STW2ymbXJKv8LdBJ
         Kvjc1LhjWqwMQ==
Date:   Tue, 7 Mar 2023 20:47:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, tiwai@suse.com,
        kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: tas2781: Add tas2781 driver
Message-ID: <5c1969de-eecc-47c6-9d66-4214a94c7841@sirena.org.uk>
References: <20230227153811.2395-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lQU1DPpVCHsKNNEx"
Content-Disposition: inline
In-Reply-To: <20230227153811.2395-1-luminlong@139.com>
X-Cookie: A rolling stone gathers momentum.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lQU1DPpVCHsKNNEx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2023 at 11:38:11PM +0800, Kevin Lu wrote:
> Create tas2781 driver.

Quite a few comments below, a lot of them are fairly simple stylistic
ones rather than substantial things but there are a few bigger things.
A lot of the bigger comments are essentially that the driver is doing
more work than it needs to be and could either stop doing things that
seem redundant or use generic functionality.

The bulk of the code looks good though.

>=20
> ---
> Changes in v3:
>  - fixed issues reported-by: kernel test robot <lkp@intel.com>
>  - correct all the inconsistent indenting warnings
>  - correct uninitialized symbol 'pwr_state'
>  - correct unsigned 'val' is never less than zero
>  - correct 'tas_dev' could be null
>=20
> Signed-off-by: Kevin Lu <luminlong@139.com>

Your signoff needs to go before the ---, tooling will remove anything
after the --- but your signoff needs to stay.

>  snd-soc-tas2562-objs :=3D tas2562.o
>  snd-soc-tas2764-objs :=3D tas2764.o
>  snd-soc-tas2780-objs :=3D tas2780.o
> +snd-soc-tas2781-objs :=3D	tas2781-i2c.o tas2781-dsp.o
>  # Mux

Please keep the blank line in the file.

> --- /dev/null
> +++ b/sound/soc/codecs/tas2781-dsp.c
> @@ -0,0 +1,2261 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
> + *

Please make the entire comment block a C++ one so things look more
intentional.

> +static const unsigned char crc8_lookup_table[CRC8_TABLE_SIZE] =3D {
> +	0x00, 0x4D, 0x9A, 0xD7, 0x79, 0x34, 0xE3, 0xAE,
> +	0xF2, 0xBF, 0x68, 0x25, 0x8B, 0xC6, 0x11, 0x5C,

Should the driver be using one of the crc8_populate_() functions here?

> +	ret =3D check_yram(&crc_data, book, page, reg, len);
> +	dev_info(tasdevice->dev,
> +		"isYRAM: Bk 0x%02x, Pg 0x%02x, Rg 0x%02x\n",
> +		book, page, reg);
> +	dev_info(tasdevice->dev,
> +		"isYRAM: crc_data.mnLen 0x%x, len 0x%x, nResult %d\n",
> +		crc_data.len, len, ret);

There's a lot of logging in this firmware load code which should at
least be reduced to dbg level if not vdbg, it's pretty loud and it looks
like at least some of it can be triggered after initial boot.

> +/* max. length of the alsa mixer control name */
> +#define MAX_CONTROL_NAME		(48)

This should be coming from the ALSA headers.


> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		(struct tasdevice_priv *)pContext;

The kernel doesn't gennerally use hungarian notation (I see a bunch of
it in the driver, n_result and p_tasdevice for example), and if there's
a need to cast away from void that usually means something's gone wrong
- it looks unneeded here so you can just remove the cast.

> +	if (config_offset + 4 > (int)config_size) {
> +		dev_err(tas_dev->dev,
> +			"add config: Out of memory\n");

This isn't OOM though?

> +	cfg_info->blk_data =3D kcalloc(
> +		cfg_info->nblocks, sizeof(struct tasdev_blk_data *),
> +		GFP_KERNEL);
> +	if (!cfg_info->blk_data) {
> +		dev_err(tas_dev->dev,
> +			"add config: blk_data alloc failed!\n");

No need to log failures to allocate, the kernel is already pretty loud
when it runs out of memory.

> +static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
> +       struct snd_ctl_elem_value *ucontrol)

> +	/* Read the primary device as the whole */
> +	ret =3D tasdevice_dev_read(tas_dev, 0, mc->reg, &val);
> +	if (ret) {
> +		dev_err(tas_dev->dev,
> +		"%s, get digital vol error\n",
> +		__func__);
> +		goto out;

Your regmap looked like it already had paging support so I'm not clear
why this is a custom control - can't you just use the standard ASoC
helpers, the regmap paging support will work for paged register maps?

> +	}
> +	val =3D (val > mc->max) ? mc->max : val;
> +	val =3D mc->invert ? mc->max - val : val;

Please write normal conditional statements, they're easier to read than
the ternery opreator.

> +static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *codec
> +		=3D snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *tas_dev =3D
> +		snd_soc_component_get_drvdata(codec);
> +	struct soc_mixer_control *mc =3D
> +		(struct soc_mixer_control *)kcontrol->private_value;
> +	int val;
> +	int i, ret =3D 0;

Please run the mixer-test selftest on a card with this device, it'll
tell you that this function doesn't return 1 on value changes so doesn't
generate events for changes.  Similar issues with a lot of other custom
controls.

> +static const struct snd_kcontrol_new tas2781_snd_controls[] =3D {
> +	SOC_SINGLE_RANGE_EXT_TLV("Amp Gain Volume", TAS2781_AMP_LEVEL,
> +		1, 0, 20, 0, tas2781_amp_getvol,
> +		tas2781_amp_putvol, amp_vol_tlv),
> +	SOC_SINGLE_RANGE_EXT_TLV("Digital Volume Control", TAS2781_DVC_LVL,
> +		0, 0, 200, 1, tas2781_digital_getvol,
> +		tas2781_digital_putvol, dvc_tlv),

Control names for volumes should end with Volume, see control-names.rst.

> +static int tasdevice_info_programs(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *codec
> +		=3D snd_soc_kcontrol_component(kcontrol);
> +	struct tasdevice_priv *p_tasdevice =3D
> +		snd_soc_component_get_drvdata(codec);
> +	struct tasdevice_fw *tas_fw =3D p_tasdevice->fmw;
> +
> +	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
> +	/* Codec Lock Hold*/
> +	mutex_lock(&p_tasdevice->codec_lock);
> +	uinfo->count =3D 1;
> +	uinfo->value.integer.min =3D 0;
> +	uinfo->value.integer.max =3D (int)tas_fw->n_programs;
> +	/* Codec Lock Release*/
> +	mutex_unlock(&p_tasdevice->codec_lock);

Why does this need a lock - what might be changing?  The casting is
suspicious too.

> +static void tasdevice_rca_ready(const struct firmware *fmw,
> +	void *context)
> +{

> +	mutex_lock(&tas_dev->codec_lock);
> +	rca =3D &(tas_dev->rcabin);
> +	fw_hdr =3D &(rca->fw_hdr);
> +	if (unlikely(!fmw) || unlikely(!fmw->data)) {

If you're not in a *very* hot path it's seldom useful to annotate with
likely() or unlikely().

> +static void tasdevice_enable_irq(
> +	struct tasdevice_priv *tas_dev, bool enable)
> +{
> +	if (enable) {
> +		if (tas_dev->irq_info.is_irq_enable)
> +			return;
> +		if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
> +			enable_irq(tas_dev->irq_info.irq);
> +		tas_dev->irq_info.is_irq_enable =3D true;

The driver shouldn't need to care if the interrupt is implemented with
something that can also be a GPIO, and indeed I can't see anything that
actually looks at the GPIO other than these checks.  The check for
double enalbes also seems suspicious, I don't think it's needed but...

> +	} else {
> +		if (gpio_is_valid(tas_dev->irq_info.irq_gpio))
> +			disable_irq_nosync(tas_dev->irq_info.irq);

=2E..it's certainly not matched in the disable path.  In general it looks
like this function is just redundant and could be replaced by
enable_irq()/disable_irq() calls in the callers, though I'm not sure
it's needed at all.

> +static void tasdevice_set_power_state(
> +	struct tasdevice_priv *tas_dev, int state)
> +{
> +	switch (state) {
> +	case 0:
> +		schedule_delayed_work(&tas_dev->tuning_switch_wrk,
> +			msecs_to_jiffies(20));
> +		break;
> +	default:
> +		if (!(tas_dev->pstream || tas_dev->cstream)) {
> +			if (tas_dev->irq_work_func)
> +				tasdevice_enable_irq(tas_dev, false);
> +			tasdevice_select_cfg_blk(tas_dev,
> +				tas_dev->rcabin.profile_cfg_id,
> +				TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
> +		}
> +		break;
> +	}

It's really not clear what thisis supposed to do - what are the two
power states here?

> +static int tasdevice_dapm_event(struct snd_soc_dapm_widget *w,
> +			struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_component *codec =3D snd_soc_dapm_to_component(w->dapm);
> +	struct tasdevice_priv *tas_dev =3D snd_soc_component_get_drvdata(codec);
> +	int stream;
> +
> +	/* Codec Lock Hold */
> +	mutex_lock(&tas_dev->codec_lock);
> +	stream =3D strcmp(w->name, "SPK") ? SNDRV_PCM_STREAM_PLAYBACK :
> +		SNDRV_PCM_STREAM_CAPTURE;
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		dev_info(tas_dev->dev, "SND_SOC_DAPM_POST_PMU\n");

dev_info() on DAPM events is going to be way too noisy, there's a lot of
logging in the core so you can probably just remove this.

> +	case SND_SOC_DAPM_PRE_PMD:
> +		dev_info(tas_dev->dev, "SND_SOC_DAPM_PRE_PMD\n");
> +		/* stop DSP only when both playback and capture streams
> +		 * are deactivated
> +		 */
> +		if (stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
> +			tas_dev->pstream =3D 0;
> +		else
> +			tas_dev->cstream =3D 0;
> +		if (tas_dev->pstream !=3D 0 || tas_dev->cstream !=3D 0)
> +			goto out;

It would probably be easier to have a supply widget that feeds both the
ASI and speaker widgets, that way DAPM will reference count for you and
the driver can just handle the event without these checks.

> +static int tasdevice_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
> +{
> +	struct tasdevice_priv *tas_dev =3D snd_soc_dai_get_drvdata(dai);
> +	unsigned int fsrate;
> +	unsigned int slot_width;
> +	int bclk_rate;
> +	int rc =3D 0;
> +
> +	dev_info(tas_dev->dev, "%s: %s\n",
> +		__func__, substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK ?
> +		"Playback":"Capture");

Again, too much logging.  The driver should be silent during normal
operation - some logging on boot or error is fine but userspace
shouldn't be able to spam the logs and hide other information.

> +static int tasdevice_set_dai_sysclk(struct snd_soc_dai *codec_dai,
> +	int clk_id, unsigned int freq, int dir)
> +{
> +	struct tasdevice_priv *tas_dev =3D snd_soc_dai_get_drvdata(codec_dai);
> +
> +	dev_info(tas_dev->dev,
> +		"%s: clk_id =3D %d, freq =3D %u, CLK direction %s\n",
> +		__func__, clk_id, freq,
> +		dir =3D=3D TASDEVICE_CLK_DIR_OUT ? "OUT":"IN");
> +
> +	return 0;
> +}

You can just remove this, it doesn't do anything except log.

> +static void tasdevice_codec_remove(
> +	struct snd_soc_component *codec)
> +{

Weird indentation here.

> +static void irq_work_routine(struct work_struct *pWork)
> +{
> +	struct tasdevice_priv *tas_dev =3D
> +		container_of(pWork, struct tasdevice_priv,
> +		irq_info.irq_work.work);
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +	if (tas_dev->runtime_suspend) {
> +		dev_info(tas_dev->dev, "%s, Runtime Suspended\n", __func__);
> +		goto end;
> +	}
> +	/*Logical Layer IRQ function, return is ignored*/
> +	if (tas_dev->irq_work_func)
> +		tas_dev->irq_work_func(tas_dev);
> +	else
> +		dev_info(tas_dev->dev,
> +			"%s, irq_work_func is NULL\n", __func__);
> +end:
> +	mutex_unlock(&tas_dev->codec_lock);
> +}

There is only one function that's ever assigned for the irq_work_func,
just inline it and don't bother with the pointer in the driver
structure - that should be a lot simpler.

> +static void tas2781_irq_work_func(struct tasdevice_priv *tas_dev)
> +{
> +	int rc =3D 0;
> +	unsigned int reg_val =3D 0, array_size =3D 0, i =3D 0, ndev =3D 0;
> +	unsigned int int_reg_array[] =3D {
> +		TAS2781_REG_INT_LTCH0,
> +		TAS2781_REG_INT_LTCH1,
> +		TAS2781_REG_INT_LTCH1_0,
> +		TAS2781_REG_INT_LTCH2,
> +		TAS2781_REG_INT_LTCH3,
> +		TAS2781_REG_INT_LTCH4};
> +
> +	tasdevice_enable_irq(tas_dev, false);

It needs to be a lot clearer what will reenable the interrupt - some
comments would help, I see there's some interlock with tuning_switch_routin=
e()
but I'm not clear what that does...

> +	array_size =3D ARRAY_SIZE(int_reg_array);
> +
> +	for (ndev =3D 0; ndev < tas_dev->ndev; ndev++) {
> +		for (i =3D 0; i < array_size; i++) {
> +			rc =3D tasdevice_dev_read(tas_dev,
> +				ndev, int_reg_array[i], &reg_val);
> +			if (!rc)
> +				dev_info(tas_dev->dev,
> +					"INT STATUS REG 0x%04x=3D0x%02x\n",
> +					int_reg_array[i], reg_val);
> +			else
> +				dev_err(tas_dev->dev,
> +					"Read Reg 0x%04x error(rc=3D%d)\n",
> +					int_reg_array[i], rc);
> +		}
> +	}
> +}

=2E..and this seems to just read the interrupt status registers and log
the results so do we even need to enable the interrupt?

> +static int tasdevice_parse_dt(struct tasdevice_priv *tas_dev)
> +{
> +	struct device_node *np =3D tas_dev->dev->of_node;
> +	int rc =3D 0, i =3D 0, ndev =3D 0;
> +	unsigned int dev_addrs[max_chn];
> +	struct i2c_client *client =3D (struct i2c_client *)tas_dev->client;

If you're adding DT bindings you need to send a DT bindings document.

> +static int tasdevice_change_chn_book(struct tasdevice_priv *tas_dev,
> +	enum channel chn, int book)
> +{

As I said earlier the regmap uses ranges so I'm not clear why there's
open coding of page changing?

> +static void tas2781_set_global_mode(struct tasdevice_priv *tas_dev)
> +{
> +	int i =3D 0;
> +	int ret =3D 0;

What's all this global mode stuff about?  It's not clear from the code.

> +	mutex_init(&tas_dev->codec_lock);
> +	ret =3D devm_snd_soc_register_component(tas_dev->dev,
> +		&soc_codec_driver_tasdevice,
> +		tasdevice_dai_driver, ARRAY_SIZE(tasdevice_dai_driver));
> +	if (ret)
> +		dev_err(tas_dev->dev, "%s: codec register error:0x%08x\n",
> +			__func__, ret);
> +
> +	INIT_DELAYED_WORK(&tas_dev->irq_info.irq_work, irq_work_routine);
> +	tas_dev->irq_info.is_irq_enable =3D false;

Shouldn't this happen before we register with the core?

> +static int tasdevice_pm_suspend(struct device *dev)
> +{
> +	struct tasdevice_priv *tas_dev =3D dev_get_drvdata(dev);
> +
> +	mutex_lock(&tas_dev->codec_lock);
> +	tas_dev->runtime_suspend =3D true;
> +
> +	if (tas_dev->irq_work_func) {
> +		if (delayed_work_pending(&tas_dev->irq_info.irq_work)) {
> +			dev_dbg(tas_dev->dev, "cancel IRQ work\n");
> +			cancel_delayed_work_sync(&tas_dev->irq_info.irq_work);
> +		}
> +	}

Just cancelling the work unconditionally should do the right thing,
though given that there's no configuration done for the device it's
unclear why we're implementing runtime suspend at all?

> +static int tasdevice_i2c_probe(struct i2c_client *i2c,
> +	const struct i2c_device_id *id)
> +{
> +	struct tasdevice_priv *tas_dev =3D NULL;
> +	int ret =3D 0;
> +
> +	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
> +		dev_err(&i2c->dev,
> +			"%s: I2C check failed\n", __func__);
> +		ret =3D -ENODEV;
> +		goto out;
> +	}

Why the functionality check?

--lQU1DPpVCHsKNNEx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQHovsACgkQJNaLcl1U
h9Aelgf/WkJn8VsG53rO+GHNts0WNAKXwXm02eKypc7LCO+LntmsSCFmYuyLZPuN
byT5pIl41XMMy25kgBzpoenM25BmPUZxuC37FJHR2KPFznIJKOX2sOnqq46vfv2J
YPpwDE1JVmLS9Cpy/mRMFmRw1UemcVE9GmtOnQebtOVrvzI8/AMAb9wTnQNM3E27
U5P/esjgRJ1rvd8/hVUSnTTuNNaCzB+vv5k4JdSZsc6plI/hh4z0J95ZidGM/29w
pjv328Jtji0GfxJ1I5P3oqcfc2ql7tBGpxS5GsX9NhJTEfP5c/toQRexrdMOefEm
Dl2wa8Xa8LDJHucRLqyzs0m9KQ/JRw==
=+zaI
-----END PGP SIGNATURE-----

--lQU1DPpVCHsKNNEx--

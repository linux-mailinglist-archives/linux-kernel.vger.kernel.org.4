Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B419643800
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiLEWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiLEWYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:24:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973AE1D3;
        Mon,  5 Dec 2022 14:24:10 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84B55660036F;
        Mon,  5 Dec 2022 22:24:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670279048;
        bh=e4NZ5iFusXdYURIq/sYDh/SiLeW3tyBmoHgdaHMKZuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNpDemM/tig04dlGbRZnwynIgXXSvQaDDOg0onfRM7j5/xR1L2jA9BzLupz3J7OQM
         ntSN9mvitlOYiQCgAx3F4JF+97xs4hpC8aY9qKqoEDwlQxjXlfearJJ4nZX/vsFQ4e
         muZNQ7iLQzVGRIl9DSE7v12GFF9swEraKbPEGSvfuoiW7b3WZU8jWR5jMKMRPOvf/C
         uTQ4xSASnKX6I1pxzuFohZ/Bs0rjuwVtZpyTvqUTqE8hYHV4j5G0XBvnFFgT6UzLwN
         OgdFB0p2z9W9sySwtMi97bh4abgJ2f02eKfrzFXSyAIFSik7/do3rj0Q/O0Xb2jKRZ
         vzajNLypmjmqA==
Received: by mercury (Postfix, from userid 1000)
        id 04AFC1060F2F; Mon,  5 Dec 2022 23:24:06 +0100 (CET)
Date:   Mon, 5 Dec 2022 23:24:05 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ye.xingchen@zte.com.cn
Cc:     linus.walleij@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] power: supply: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <20221205222405.tbwvyli2zkpktnl7@mercury.elektranox.org>
References: <202212051107581630594@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y76jcgokg5obycth"
Content-Disposition: inline
In-Reply-To: <202212051107581630594@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y76jcgokg5obycth
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 05, 2022 at 11:07:58AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>=20
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>=20
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---

Looks sensible. But the merge window will open soon, so this will
have to wait. It would be nice if you can prepare a v2, which
includes

 * Moving remaining scnprintf to sysfs_emit_at in
   drivers/power/supply/twl4030_charger.c
 * Updateing usage of sprintf based sysfs show()
   routines in addition to the scnprintf ones

Thanks,

-- Sebastian

>  drivers/power/supply/ab8500_fg.c        | 18 +++++++++---------
>  drivers/power/supply/bq24190_charger.c  |  2 +-
>  drivers/power/supply/bq24257_charger.c  |  8 +++-----
>  drivers/power/supply/lp8788-charger.c   |  7 +++----
>  drivers/power/supply/max14577_charger.c |  2 +-
>  drivers/power/supply/max77693_charger.c |  6 +++---
>  6 files changed, 20 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index c6c9804280db..d989eadaa933 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2594,7 +2594,7 @@ static ssize_t ab8505_powercut_flagtime_read(struct=
 device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2644,7 +2644,7 @@ static ssize_t ab8505_powercut_maxtime_read(struct =
device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2695,7 +2695,7 @@ static ssize_t ab8505_powercut_restart_read(struct =
device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0xF));
>=20
>  fail:
>  	return ret;
> @@ -2746,7 +2746,7 @@ static ssize_t ab8505_powercut_timer_read(struct de=
vice *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7F));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
>=20
>  fail:
>  	return ret;
> @@ -2769,7 +2769,7 @@ static ssize_t ab8505_powercut_restart_counter_read=
(struct device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0xF0) >> 4);
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0xF0) >> 4);
>=20
>  fail:
>  	return ret;
> @@ -2790,7 +2790,7 @@ static ssize_t ab8505_powercut_read(struct device *=
dev,
>  	if (ret < 0)
>  		goto fail;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x1));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x1));
>=20
>  fail:
>  	return ret;
> @@ -2841,7 +2841,7 @@ static ssize_t ab8505_powercut_flag_read(struct dev=
ice *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x10) >> 4));
> +	return sysfs_emit(buf, "%d\n", ((reg_value & 0x10) >> 4));
>=20
>  fail:
>  	return ret;
> @@ -2864,7 +2864,7 @@ static ssize_t ab8505_powercut_debounce_read(struct=
 device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (reg_value & 0x7));
> +	return sysfs_emit(buf, "%d\n", (reg_value & 0x7));
>=20
>  fail:
>  	return ret;
> @@ -2914,7 +2914,7 @@ static ssize_t ab8505_powercut_enable_status_read(s=
truct device *dev,
>  		goto fail;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ((reg_value & 0x20) >> 5));
> +	return sysfs_emit(buf, "%d\n", ((reg_value & 0x20) >> 5));
>=20
>  fail:
>  	return ret;
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 2b2c3a4391c1..be34b9848450 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -463,7 +463,7 @@ static ssize_t bq24190_sysfs_show(struct device *dev,
>  	if (ret)
>  		count =3D ret;
>  	else
> -		count =3D scnprintf(buf, PAGE_SIZE, "%hhx\n", v);
> +		count =3D sysfs_emit(buf, "%hhx\n", v);
>=20
>  	pm_runtime_mark_last_busy(bdi->dev);
>  	pm_runtime_put_autosuspend(bdi->dev);
> diff --git a/drivers/power/supply/bq24257_charger.c b/drivers/power/suppl=
y/bq24257_charger.c
> index ab4c49788c58..103ddc2b3def 100644
> --- a/drivers/power/supply/bq24257_charger.c
> +++ b/drivers/power/supply/bq24257_charger.c
> @@ -767,8 +767,7 @@ static ssize_t bq24257_show_ovp_voltage(struct device=
 *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct bq24257_device *bq =3D power_supply_get_drvdata(psy);
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> -			 bq24257_vovp_map[bq->init_data.vovp]);
> +	return sysfs_emit(buf, "%u\n", bq24257_vovp_map[bq->init_data.vovp]);
>  }
>=20
>  static ssize_t bq24257_show_in_dpm_voltage(struct device *dev,
> @@ -778,8 +777,7 @@ static ssize_t bq24257_show_in_dpm_voltage(struct dev=
ice *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct bq24257_device *bq =3D power_supply_get_drvdata(psy);
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> -			 bq24257_vindpm_map[bq->init_data.vindpm]);
> +	return sysfs_emit(buf, "%u\n", bq24257_vindpm_map[bq->init_data.vindpm]=
);
>  }
>=20
>  static ssize_t bq24257_sysfs_show_enable(struct device *dev,
> @@ -800,7 +798,7 @@ static ssize_t bq24257_sysfs_show_enable(struct devic=
e *dev,
>  	if (ret < 0)
>  		return ret;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
> +	return sysfs_emit(buf, "%d\n", ret);
>  }
>=20
>  static ssize_t bq24257_sysfs_set_enable(struct device *dev,
> diff --git a/drivers/power/supply/lp8788-charger.c b/drivers/power/supply=
/lp8788-charger.c
> index f5f47a0aa1e3..755b6a4379b8 100644
> --- a/drivers/power/supply/lp8788-charger.c
> +++ b/drivers/power/supply/lp8788-charger.c
> @@ -602,7 +602,7 @@ static ssize_t lp8788_show_charger_status(struct devi=
ce *dev,
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_STATUS, &data);
>  	state =3D (data & LP8788_CHG_STATE_M) >> LP8788_CHG_STATE_S;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", desc[state]);
> +	return sysfs_emit(buf, "%s\n", desc[state]);
>  }
>=20
>  static ssize_t lp8788_show_eoc_time(struct device *dev,
> @@ -618,8 +618,7 @@ static ssize_t lp8788_show_eoc_time(struct device *de=
v,
>  	lp8788_read_byte(pchg->lp, LP8788_CHG_EOC, &val);
>  	val =3D (val & LP8788_CHG_EOC_TIME_M) >> LP8788_CHG_EOC_TIME_S;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "End Of Charge Time: %s\n",
> -			stime[val]);
> +	return sysfs_emit(buf, "End Of Charge Time: %s\n", stime[val]);
>  }
>=20
>  static ssize_t lp8788_show_eoc_level(struct device *dev,
> @@ -642,7 +641,7 @@ static ssize_t lp8788_show_eoc_level(struct device *d=
ev,
>  	val =3D (val & LP8788_CHG_EOC_LEVEL_M) >> LP8788_CHG_EOC_LEVEL_S;
>  	level =3D mode ? abs_level[val] : relative_level[val];
>=20
> -	return scnprintf(buf, PAGE_SIZE, "End Of Charge Level: %s\n", level);
> +	return sysfs_emit(buf, "End Of Charge Level: %s\n", level);
>  }
>=20
>  static DEVICE_ATTR(charger_status, S_IRUSR, lp8788_show_charger_status, =
NULL);
> diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supp=
ly/max14577_charger.c
> index f244cd902eb9..96f9de775043 100644
> --- a/drivers/power/supply/max14577_charger.c
> +++ b/drivers/power/supply/max14577_charger.c
> @@ -532,7 +532,7 @@ static ssize_t show_fast_charge_timer(struct device *=
dev,
>  		break;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static ssize_t store_fast_charge_timer(struct device *dev,
> diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supp=
ly/max77693_charger.c
> index a2c5c9858639..794c8c054450 100644
> --- a/drivers/power/supply/max77693_charger.c
> +++ b/drivers/power/supply/max77693_charger.c
> @@ -296,7 +296,7 @@ static ssize_t fast_charge_timer_show(struct device *=
dev,
>  		break;
>  	}
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_fast_charge_timer(struct max77693_charger *chg,
> @@ -357,7 +357,7 @@ static ssize_t top_off_threshold_current_show(struct =
device *dev,
>  	else
>  		val =3D data * 50000;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_top_off_threshold_current(struct max77693_charge=
r *chg,
> @@ -405,7 +405,7 @@ static ssize_t top_off_timer_show(struct device *dev,
>=20
>  	val =3D data * 10;
>=20
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", val);
> +	return sysfs_emit(buf, "%u\n", val);
>  }
>=20
>  static int max77693_set_top_off_timer(struct max77693_charger *chg,
> --=20
> 2.25.1

--y76jcgokg5obycth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOOb30ACgkQ2O7X88g7
+prCrA/+OSkqk6pe6Cs0SEXh6KWYPiGlJ/v21WthbReXb+3gUsXcJuTOKu60Hrjm
CvbfL7cD0goVGqVZd5oej8N+h442xSgehDzY0ojbe/4BKw0SxLkepvjDhCBSpQtH
8PnwF9dNB5E2+wsm3YR7w3NAmmodQQOZtrDWVMqfgdWPjsQDznWjRwcTG6uBbJwd
7lSCKVtGOefFidzqpT2KNL76uQXH/gunaOrIBErATw1DJn/k2UgowHBM4A+nfcBZ
KoVY8Qr+6bEKbvMQDTuKAYiIPD1oC6DtViAfcOCximWHce6mZ86aF7sK10ep7/Tm
FlPKjtBaodajDoCPixL63MhX0bMfyrWpGS6iQsQrferPnfyUQmHelxHNPO6eedJb
4QMGq/joSlhSwSsLK0ydvsh3HwYF5D/ufZEOOpo/vZ2FRyaciZ9BlQmr7zG55mY5
YzEJlGSmVAVXtqCf/2AHb7ZsHrEJtnPfhXIOZ+sZd5OpBZXJCi6gK6D+aWAQDJeD
g5diKFNalMcSlEX/NRk6rR+0NDs0ul7P/PC944LgjttELQ89ublLTItDTbYaemY9
40dEBRt1/aIrSVJ9UrRdtdIhFDmvJUD8OU+QIIctZuey61jZSP/dT1xtCX4rnPUX
DMRfjxJnqQkKlhr5Pdi8oonX2YCWyNxhiXPSwL9xINWhYSG1/3g=
=jQYW
-----END PGP SIGNATURE-----

--y76jcgokg5obycth--

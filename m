Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCDE73000F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244994AbjFNN3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244824AbjFNN3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:29:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6B1BE8;
        Wed, 14 Jun 2023 06:29:33 -0700 (PDT)
Received: from mercury (dyndsl-091-248-213-214.ewe-ip-backbone.de [91.248.213.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8CD46606F20;
        Wed, 14 Jun 2023 14:29:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686749371;
        bh=TpyFWe22P+gPWCC9qoi44CUiTnY5DQPtqdAdnkHFmC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAqim0fxYF2zz9cZp9dNSIBK+DCw5pablgr0QFsX5MfN6xJ74J5K6PRtrXMXJZhHT
         hpP4Zw/o8EWJJ24qXT33mc+tC4IekkSE9SzjUE8TsNqvtrxTdOLhCrmap6g5TdhhxY
         +M222RpG2wuHR8Gx3niscVYrRzhSbRMzis5u+gcA5XJxAbTLycsoZOjmlDct2ba3eB
         FRZacPwsF/9kXZ62eLjfa5dFMpyFITZe/CLBMXZoRC+aJ7gnarxbVpsCl4GsXUey58
         NANbh5UIjeajIjE428qpWzhrUWCIHN/7xVcwhc04EmerkSLu3irvc5t+QYpuKr3s8w
         eALm+OEJ4Vs5w==
Received: by mercury (Postfix, from userid 1000)
        id 333921060A04; Wed, 14 Jun 2023 15:29:29 +0200 (CEST)
Date:   Wed, 14 Jun 2023 15:29:29 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 16/25] PM / devfreq: rockchip-dfi: Add perf support
Message-ID: <20230614132929.gorgfdbx3hjg2knj@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-17-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="463vti2ltg2ex72b"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-17-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--463vti2ltg2ex72b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:44AM +0200, Sascha Hauer wrote:
> The DFI is a unit which is suitable for measuring DDR utilization, but
> so far it could only be used as an event driver for the DDR frequency
> scaling driver. This adds perf support to the DFI driver.
>=20
> Usage with the 'perf' tool can look like:
>=20
> perf stat -a -e rockchip_ddr/cycles/,\
> 		rockchip_ddr/read-bytes/,\
> 		rockchip_ddr/write-bytes/,\
> 		rockchip_ddr/bytes/ sleep 1
>=20
>  Performance counter stats for 'system wide':
>=20
>         1582524826      rockchip_ddr/cycles/
>            1802.25 MB   rockchip_ddr/read-bytes/
>            1793.72 MB   rockchip_ddr/write-bytes/
>            3595.90 MB   rockchip_ddr/bytes/
>=20
>        1.014369709 seconds time elapsed
>=20
> perf support has been tested on a RK3568 and a RK3399, the latter with
> dual channel DDR.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
>=20
> Notes:
>     Changes since v4:
>    =20
>     - use __stringify to ensure event type definitions and event numbers =
in sysfs are consistent
>     - only use 64bit values in structs holding counters
>     - support monitoring individual DDR channels
>     - fix return value in rockchip_ddr_perf_event_init(): -EOPNOTSUPP -> =
-EINVAL
>     - check for invalid event->attr.config values
>     - start hrtimer to trigger in one second, not immediately
>     - use devm_add_action_or_reset()
>     - add suppress_bind_attrs
>     - enable DDRMON during probe when perf is enabled
>     - use a seqlock to protect perf reading the counters from the hrtimer=
 callback modifying them
>=20
>  drivers/devfreq/event/rockchip-dfi.c | 439 ++++++++++++++++++++++++++-
>  include/soc/rockchip/rk3399_grf.h    |   2 +
>  include/soc/rockchip/rk3568_grf.h    |   1 +
>  3 files changed, 437 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event=
/rockchip-dfi.c
> index 50e497455dc69..88145688e3d9c 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -16,10 +16,12 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
> +#include <linux/seqlock.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/perf_event.h>
> =20
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
> @@ -41,19 +43,39 @@
>  					 DDRMON_CTRL_LPDDR4 | \
>  					 DDRMON_CTRL_LPDDR23)
> =20
> +#define DDRMON_CH0_WR_NUM		0x20
> +#define DDRMON_CH0_RD_NUM		0x24
>  #define DDRMON_CH0_COUNT_NUM		0x28
>  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> =20
> +#define PERF_EVENT_CYCLES		0x0
> +#define PERF_EVENT_READ_BYTES		0x1
> +#define PERF_EVENT_WRITE_BYTES		0x2
> +#define PERF_EVENT_READ_BYTES0		0x3
> +#define PERF_EVENT_WRITE_BYTES0		0x4
> +#define PERF_EVENT_READ_BYTES1		0x5
> +#define PERF_EVENT_WRITE_BYTES1		0x6
> +#define PERF_EVENT_READ_BYTES2		0x7
> +#define PERF_EVENT_WRITE_BYTES2		0x8
> +#define PERF_EVENT_READ_BYTES3		0x9
> +#define PERF_EVENT_WRITE_BYTES3		0xa
> +#define PERF_EVENT_BYTES		0xb
> +#define PERF_ACCESS_TYPE_MAX		0xc
> +
>  /**
>   * struct dmc_count_channel - structure to hold counter values from the =
DDR controller
>   * @access:       Number of read and write accesses
>   * @clock_cycles: DDR clock cycles
> + * @read_access:  number of read accesses
> + * @write_acccess: number of write accesses
>   */
>  struct dmc_count_channel {
> -	u32 access;
> -	u32 clock_cycles;
> +	u64 access;
> +	u64 clock_cycles;
> +	u64 read_access;
> +	u64 write_access;
>  };
> =20
>  struct dmc_count {
> @@ -69,6 +91,11 @@ struct rockchip_dfi {
>  	struct devfreq_event_dev *edev;
>  	struct devfreq_event_desc desc;
>  	struct dmc_count last_event_count;
> +
> +	struct dmc_count last_perf_count;
> +	struct dmc_count total_count;
> +	seqlock_t count_seqlock; /* protects last_perf_count and total_count */
> +
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct regmap *regmap_pmu;
> @@ -77,6 +104,14 @@ struct rockchip_dfi {
>  	struct mutex mutex;
>  	u32 ddr_type;
>  	unsigned int channel_mask;
> +	enum cpuhp_state cpuhp_state;
> +	struct hlist_node node;
> +	struct pmu pmu;
> +	struct hrtimer timer;
> +	unsigned int cpu;
> +	int active_events;
> +	int burst_len;
> +	int buswidth[DMC_MAX_CHANNELS];
>  };
> =20
>  static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
> @@ -145,7 +180,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi =
*dfi)
>  	mutex_unlock(&dfi->mutex);
>  }
> =20
> -static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct =
dmc_count *count)
> +static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct =
dmc_count *c)
>  {
>  	u32 i;
>  	void __iomem *dfi_regs =3D dfi->regs;
> @@ -153,13 +188,36 @@ static void rockchip_dfi_read_counters(struct rockc=
hip_dfi *dfi, struct dmc_coun
>  	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
>  		if (!(dfi->channel_mask & BIT(i)))
>  			continue;
> -		count->c[i].access =3D readl_relaxed(dfi_regs +
> +		c->c[i].read_access =3D readl_relaxed(dfi_regs +
> +				DDRMON_CH0_RD_NUM + i * 20);
> +		c->c[i].write_access =3D readl_relaxed(dfi_regs +
> +				DDRMON_CH0_WR_NUM + i * 20);
> +		c->c[i].access =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_DFI_ACCESS_NUM + i * 20);
> -		count->c[i].clock_cycles =3D readl_relaxed(dfi_regs +
> +		c->c[i].clock_cycles =3D readl_relaxed(dfi_regs +
>  				DDRMON_CH0_COUNT_NUM + i * 20);
>  	}
>  }
> =20
> +static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
> +					   const struct dmc_count *now,
> +					   struct dmc_count *res)
> +{
> +	const struct dmc_count *last =3D &dfi->last_perf_count;
> +	int i;
> +
> +	for (i =3D 0; i < DMC_MAX_CHANNELS; i++) {
> +		res->c[i].read_access =3D dfi->total_count.c[i].read_access +
> +			(u32)(now->c[i].read_access - last->c[i].read_access);
> +		res->c[i].write_access =3D dfi->total_count.c[i].write_access +
> +			(u32)(now->c[i].write_access - last->c[i].write_access);
> +		res->c[i].access =3D dfi->total_count.c[i].access +
> +			(u32)(now->c[i].access - last->c[i].access);
> +		res->c[i].clock_cycles =3D dfi->total_count.c[i].clock_cycles +
> +			(u32)(now->c[i].clock_cycles - last->c[i].clock_cycles);
> +	}
> +}
> +
>  static int rockchip_dfi_event_disable(struct devfreq_event_dev *edev)
>  {
>  	struct rockchip_dfi *dfi =3D devfreq_event_get_drvdata(edev);
> @@ -223,6 +281,367 @@ static const struct devfreq_event_ops rockchip_dfi_=
ops =3D {
>  	.set_event =3D rockchip_dfi_set_event,
>  };
> =20
> +#ifdef CONFIG_PERF_EVENTS
> +
> +static ssize_t ddr_perf_cpumask_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pmu *pmu =3D dev_get_drvdata(dev);
> +	struct rockchip_dfi *dfi =3D container_of(pmu, struct rockchip_dfi, pmu=
);
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(dfi->cpu));
> +}
> +
> +static struct device_attribute ddr_perf_cpumask_attr =3D
> +	__ATTR(cpumask, 0444, ddr_perf_cpumask_show, NULL);
> +
> +static struct attribute *ddr_perf_cpumask_attrs[] =3D {
> +	&ddr_perf_cpumask_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_cpumask_attr_group =3D {
> +	.attrs =3D ddr_perf_cpumask_attrs,
> +};
> +
> +PMU_EVENT_ATTR_STRING(cycles, ddr_pmu_cycles, "event=3D"__stringify(PERF=
_EVENT_CYCLES))
> +
> +#define DFI_PMU_EVENT_ATTR(_name, _var, _str) \
> +	PMU_EVENT_ATTR_STRING(_name, _var, _str); \
> +	PMU_EVENT_ATTR_STRING(_name.unit, _var##_unit, "MB"); \
> +	PMU_EVENT_ATTR_STRING(_name.scale, _var##_scale, "9.536743164e-07")
> +
> +DFI_PMU_EVENT_ATTR(read-bytes0, ddr_pmu_read_bytes0, "event=3D"__stringi=
fy(PERF_EVENT_READ_BYTES0));
> +DFI_PMU_EVENT_ATTR(write-bytes0, ddr_pmu_write_bytes0, "event=3D"__strin=
gify(PERF_EVENT_WRITE_BYTES0));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes1, ddr_pmu_read_bytes1, "event=3D"__stringi=
fy(PERF_EVENT_READ_BYTES1));
> +DFI_PMU_EVENT_ATTR(write-bytes1, ddr_pmu_write_bytes1, "event=3D"__strin=
gify(PERF_EVENT_WRITE_BYTES1));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes2, ddr_pmu_read_bytes2, "event=3D"__stringi=
fy(PERF_EVENT_READ_BYTES2));
> +DFI_PMU_EVENT_ATTR(write-bytes2, ddr_pmu_write_bytes2, "event=3D"__strin=
gify(PERF_EVENT_WRITE_BYTES2));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes3, ddr_pmu_read_bytes3, "event=3D"__stringi=
fy(PERF_EVENT_READ_BYTES3));
> +DFI_PMU_EVENT_ATTR(write-bytes3, ddr_pmu_write_bytes3, "event=3D"__strin=
gify(PERF_EVENT_WRITE_BYTES3));
> +
> +DFI_PMU_EVENT_ATTR(read-bytes, ddr_pmu_read_bytes, "event=3D"__stringify=
(PERF_EVENT_READ_BYTES));
> +DFI_PMU_EVENT_ATTR(write-bytes, ddr_pmu_write_bytes, "event=3D"__stringi=
fy(PERF_EVENT_WRITE_BYTES));
> +
> +DFI_PMU_EVENT_ATTR(bytes, ddr_pmu_bytes, "event=3D"__stringify(PERF_EVEN=
T_BYTES));
> +
> +#define DFI_ATTR_MB(_name) 		\
> +	&_name.attr.attr,		\
> +	&_name##_unit.attr.attr,	\
> +	&_name##_scale.attr.attr
> +
> +static struct attribute *ddr_perf_events_attrs[] =3D {
> +	&ddr_pmu_cycles.attr.attr,
> +	DFI_ATTR_MB(ddr_pmu_read_bytes),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes0),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes0),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes1),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes1),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes2),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes2),
> +	DFI_ATTR_MB(ddr_pmu_read_bytes3),
> +	DFI_ATTR_MB(ddr_pmu_write_bytes3),
> +	DFI_ATTR_MB(ddr_pmu_bytes),
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_events_attr_group =3D {
> +	.name =3D "events",
> +	.attrs =3D ddr_perf_events_attrs,
> +};
> +
> +PMU_FORMAT_ATTR(event, "config:0-7");
> +
> +static struct attribute *ddr_perf_format_attrs[] =3D {
> +	&format_attr_event.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ddr_perf_format_attr_group =3D {
> +	.name =3D "format",
> +	.attrs =3D ddr_perf_format_attrs,
> +};
> +
> +static const struct attribute_group *attr_groups[] =3D {
> +	&ddr_perf_events_attr_group,
> +	&ddr_perf_cpumask_attr_group,
> +	&ddr_perf_format_attr_group,
> +	NULL,
> +};
> +
> +static int rockchip_ddr_perf_event_init(struct perf_event *event)
> +{
> +	struct rockchip_dfi *dfi =3D container_of(event->pmu, struct rockchip_d=
fi, pmu);
> +
> +	if (event->attr.type !=3D event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	if (event->cpu < 0) {
> +		dev_warn(dfi->dev, "Can't provide per-task data!\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
> +{
> +	struct rockchip_dfi *dfi =3D container_of(event->pmu, struct rockchip_d=
fi, pmu);
> +	int blen =3D dfi->burst_len;
> +	struct dmc_count total, now;
> +	unsigned int seq;
> +	u64 c =3D 0;
> +	int i;
> +
> +	rockchip_dfi_read_counters(dfi, &now);
> +
> +	do {
> +		seq =3D read_seqbegin(&dfi->count_seqlock);
> +
> +		rockchip_ddr_perf_counters_add(dfi, &now, &total);
> +
> +	} while (read_seqretry(&dfi->count_seqlock, seq));
> +
> +	switch (event->attr.config) {
> +	case PERF_EVENT_CYCLES:
> +		c =3D total.c[0].clock_cycles;
> +		break;
> +	case PERF_EVENT_READ_BYTES:
> +		for (i =3D 0; i < DMC_MAX_CHANNELS; i++)
> +			c +=3D total.c[i].read_access * blen * dfi->buswidth[i];
> +		break;
> +	case PERF_EVENT_WRITE_BYTES:
> +		for (i =3D 0; i < DMC_MAX_CHANNELS; i++)
> +			c +=3D total.c[i].write_access * blen * dfi->buswidth[i];
> +		break;
> +	case PERF_EVENT_READ_BYTES0:
> +		c =3D total.c[0].read_access * blen * dfi->buswidth[0];
> +		break;
> +	case PERF_EVENT_WRITE_BYTES0:
> +		c =3D total.c[0].write_access * blen * dfi->buswidth[0];
> +		break;
> +	case PERF_EVENT_READ_BYTES1:
> +		c =3D total.c[1].read_access * blen * dfi->buswidth[1];
> +		break;
> +	case PERF_EVENT_WRITE_BYTES1:
> +		c =3D total.c[1].write_access * blen * dfi->buswidth[1];
> +		break;
> +	case PERF_EVENT_READ_BYTES2:
> +		c =3D total.c[2].read_access * blen * dfi->buswidth[2];
> +		break;
> +	case PERF_EVENT_WRITE_BYTES2:
> +		c =3D total.c[2].write_access * blen * dfi->buswidth[2];
> +		break;
> +	case PERF_EVENT_READ_BYTES3:
> +		c =3D total.c[3].read_access * blen * dfi->buswidth[3];
> +		break;
> +	case PERF_EVENT_WRITE_BYTES3:
> +		c =3D total.c[3].write_access * blen * dfi->buswidth[3];
> +		break;
> +	case PERF_EVENT_BYTES:
> +		for (i =3D 0; i < DMC_MAX_CHANNELS; i++)
> +			c +=3D total.c[i].access * blen * dfi->buswidth[i];
> +		break;
> +	}
> +
> +	return c;
> +}
> +
> +static void rockchip_ddr_perf_event_update(struct perf_event *event)
> +{
> +	u64 now;
> +	s64 prev;
> +
> +	if (event->attr.config >=3D PERF_ACCESS_TYPE_MAX)
> +		return;
> +
> +	now =3D rockchip_ddr_perf_event_get_count(event);
> +	prev =3D local64_xchg(&event->hw.prev_count, now);
> +	local64_add(now - prev, &event->count);
> +}
> +
> +static void rockchip_ddr_perf_event_start(struct perf_event *event, int =
flags)
> +{
> +	u64 now =3D rockchip_ddr_perf_event_get_count(event);
> +
> +	local64_set(&event->hw.prev_count, now);
> +}
> +
> +static int rockchip_ddr_perf_event_add(struct perf_event *event, int fla=
gs)
> +{
> +	struct rockchip_dfi *dfi =3D container_of(event->pmu, struct rockchip_d=
fi, pmu);
> +
> +	dfi->active_events++;
> +
> +	if (dfi->active_events =3D=3D 1)
> +		hrtimer_start(&dfi->timer, ns_to_ktime(NSEC_PER_SEC), HRTIMER_MODE_REL=
);
> +
> +	if (flags & PERF_EF_START)
> +		rockchip_ddr_perf_event_start(event, flags);
> +
> +	return 0;
> +}
> +
> +static void rockchip_ddr_perf_event_stop(struct perf_event *event, int f=
lags)
> +{
> +	rockchip_ddr_perf_event_update(event);
> +}
> +
> +static void rockchip_ddr_perf_event_del(struct perf_event *event, int fl=
ags)
> +{
> +	struct rockchip_dfi *dfi =3D container_of(event->pmu, struct rockchip_d=
fi, pmu);
> +
> +	rockchip_ddr_perf_event_stop(event, PERF_EF_UPDATE);
> +
> +	dfi->active_events--;
> +
> +	if (dfi->active_events =3D=3D 0)
> +		hrtimer_cancel(&dfi->timer);
> +}
> +
> +static enum hrtimer_restart rockchip_dfi_timer(struct hrtimer *timer)
> +{
> +	struct rockchip_dfi *dfi =3D container_of(timer, struct rockchip_dfi, t=
imer);
> +	struct dmc_count now, total;
> +
> +	rockchip_dfi_read_counters(dfi, &now);
> +
> +	write_seqlock(&dfi->count_seqlock);
> +
> +	rockchip_ddr_perf_counters_add(dfi, &now, &total);
> +	dfi->total_count =3D total;
> +	dfi->last_perf_count =3D now;
> +
> +	write_sequnlock(&dfi->count_seqlock);
> +
> +	hrtimer_forward_now(&dfi->timer, ns_to_ktime(NSEC_PER_SEC));
> +
> +	return HRTIMER_RESTART;
> +};
> +
> +static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *nod=
e)
> +{
> +	struct rockchip_dfi *dfi =3D hlist_entry_safe(node, struct rockchip_dfi=
, node);
> +	int target;
> +
> +	if (cpu !=3D dfi->cpu)
> +		return 0;
> +
> +	target =3D cpumask_any_but(cpu_online_mask, cpu);
> +	if (target >=3D nr_cpu_ids)
> +		return 0;
> +
> +	perf_pmu_migrate_context(&dfi->pmu, cpu, target);
> +	dfi->cpu =3D target;
> +
> +	return 0;
> +}
> +
> +static void rockchip_ddr_cpuhp_remove_state(void *data)
> +{
> +	struct rockchip_dfi *dfi =3D data;
> +
> +	cpuhp_remove_multi_state(dfi->cpuhp_state);
> +
> +	rockchip_dfi_disable(dfi);
> +}
> +
> +static void rockchip_ddr_cpuhp_remove_instance(void *data)
> +{
> +	struct rockchip_dfi *dfi =3D data;
> +
> +	cpuhp_state_remove_instance_nocalls(dfi->cpuhp_state, &dfi->node);
> +}
> +
> +static void rockchip_ddr_perf_remove(void *data)
> +{
> +	struct rockchip_dfi *dfi =3D data;
> +
> +	perf_pmu_unregister(&dfi->pmu);
> +}
> +
> +static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
> +{
> +	struct pmu *pmu =3D &dfi->pmu;
> +	int ret;
> +
> +	seqlock_init(&dfi->count_seqlock);
> +
> +	pmu->module =3D THIS_MODULE;
> +	pmu->capabilities =3D PERF_PMU_CAP_NO_EXCLUDE;
> +	pmu->task_ctx_nr =3D perf_invalid_context;
> +	pmu->attr_groups =3D attr_groups;
> +	pmu->event_init  =3D rockchip_ddr_perf_event_init;
> +	pmu->add =3D rockchip_ddr_perf_event_add;
> +	pmu->del =3D rockchip_ddr_perf_event_del;
> +	pmu->start =3D rockchip_ddr_perf_event_start;
> +	pmu->stop =3D rockchip_ddr_perf_event_stop;
> +	pmu->read =3D rockchip_ddr_perf_event_update;
> +
> +	dfi->cpu =3D raw_smp_processor_id();
> +
> +	ret =3D cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "rockchip_ddr_perf_pmu",
> +				      NULL,
> +				      ddr_perf_offline_cpu);
> +
> +	if (ret < 0) {
> +		dev_err(dfi->dev, "cpuhp_setup_state_multi failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dfi->cpuhp_state =3D ret;
> +
> +	rockchip_dfi_enable(dfi);
> +
> +	ret =3D devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_st=
ate, dfi);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D cpuhp_state_add_instance_nocalls(dfi->cpuhp_state, &dfi->node);
> +	if (ret) {
> +		dev_err(dfi->dev, "Error %d registering hotplug\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dfi->dev, rockchip_ddr_cpuhp_remove_in=
stance, dfi);
> +	if (ret)
> +		return ret;
> +
> +	hrtimer_init(&dfi->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	dfi->timer.function =3D rockchip_dfi_timer;
> +
> +	switch (dfi->ddr_type) {
> +	case ROCKCHIP_DDRTYPE_LPDDR2:
> +	case ROCKCHIP_DDRTYPE_LPDDR3:
> +		dfi->burst_len =3D 8;
> +		break;
> +	case ROCKCHIP_DDRTYPE_LPDDR4:
> +	case ROCKCHIP_DDRTYPE_LPDDR4X:
> +		dfi->burst_len =3D 16;
> +		break;
> +	}
> +
> +	ret =3D perf_pmu_register(pmu, "rockchip_ddr", -1);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dfi->dev, rockchip_ddr_perf_remove, dfi=
);
> +}
> +#else
> +static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int rk3399_dfi_init(struct rockchip_dfi *dfi)
>  {
>  	struct regmap *regmap_pmu =3D dfi->regmap_pmu;
> @@ -239,6 +658,9 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
> =20
>  	dfi->channel_mask =3D GENMASK(1, 0);
> =20
> +	dfi->buswidth[0] =3D FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) =3D=
=3D 0 ? 4 : 2;
> +	dfi->buswidth[1] =3D FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) =3D=
=3D 0 ? 4 : 2;
> +
>  	return 0;
>  };
> =20
> @@ -255,6 +677,8 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
>  	if (FIELD_GET(RK3568_PMUGRF_OS_REG3_SYSREG_VERSION, reg3) >=3D 0x3)
>  		dfi->ddr_type |=3D FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, r=
eg3) << 3;
> =20
> +	dfi->buswidth[0] =3D FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) =3D=
=3D 0 ? 4 : 2;
> +
>  	dfi->channel_mask =3D 1;
> =20
>  	return 0;
> @@ -317,6 +741,10 @@ static int rockchip_dfi_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(dfi->edev);
>  	}
> =20
> +	ret =3D rockchip_ddr_perf_init(dfi);
> +	if (ret)
> +		return ret;
> +
>  	platform_set_drvdata(pdev, dfi);
> =20
>  	return 0;
> @@ -327,6 +755,7 @@ static struct platform_driver rockchip_dfi_driver =3D=
 {
>  	.driver =3D {
>  		.name	=3D "rockchip-dfi",
>  		.of_match_table =3D rockchip_dfi_id_match,
> +		.suppress_bind_attrs =3D true,
>  	},
>  };
>  module_platform_driver(rockchip_dfi_driver);
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3=
399_grf.h
> index 775f8444bea8d..39cd44cec982f 100644
> --- a/include/soc/rockchip/rk3399_grf.h
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -12,5 +12,7 @@
>  /* PMU GRF Registers */
>  #define RK3399_PMUGRF_OS_REG2		0x308
>  #define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
> +#define RK3399_PMUGRF_OS_REG2_BW_CH0		GENMASK(3, 2)
> +#define RK3399_PMUGRF_OS_REG2_BW_CH1		GENMASK(19, 18)
> =20
>  #endif
> diff --git a/include/soc/rockchip/rk3568_grf.h b/include/soc/rockchip/rk3=
568_grf.h
> index 575584e9d8834..52853efd6720e 100644
> --- a/include/soc/rockchip/rk3568_grf.h
> +++ b/include/soc/rockchip/rk3568_grf.h
> @@ -4,6 +4,7 @@
> =20
>  #define RK3568_PMUGRF_OS_REG2		0x208
>  #define RK3568_PMUGRF_OS_REG2_DRAMTYPE_INFO		GENMASK(15, 13)
> +#define RK3568_PMUGRF_OS_REG2_BW_CH0			GENMASK(3, 2)
> =20
>  #define RK3568_PMUGRF_OS_REG3		0x20c
>  #define RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3		GENMASK(13, 12)
> --=20
> 2.39.2
>=20

--463vti2ltg2ex72b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSJwLAACgkQ2O7X88g7
+pr7pw//Wem0Yk3tqywWQCJoAN6OXpM69MyQEr1ZqQBf1NgsasBO5qmMo4vgON5h
XfkKCXnnNShxOJ3wobVfkmygQhWMcp9/vDT1tNuBUlPpnnJLVK9XmWeNSGCDU2mc
sYPGjqVv7ele2CHDh8+/HTNe3UDpbRm6Ke6POVuE58t69VIZguY4PMl1T6XgHPLk
Xztr6EQCTsXYSxo7dxXItctIv8ygUSK4m567M+7o/REKUeEqTlf7HNICADLp9622
AX3XVofFNYGXlvfSQGY2QiPfXmQc1DkWr9Z2sp1TnaYm2JItAy/j0ucHqE+2d0Hb
gni9QMLdjxgjobhWdH9MxNH8bJAghgYVJ8FbthQvvhJylXllmWP5ZWrOaJpkej8h
UxWROiLLjkoFjOvwhqKpOw+J0Ps0TUtrNJzJiwzI8GefnBRwOREgK8NVlIYGJg6+
sBvKU3gRoQDD+sO8QQ6v5AbwYz0ZxF27vmH0T0jKi4f3WklyEIcnyRWk024+Gw2T
+eQRUSZu+Hdn3CihXg92wCJz+IC9dvxYMJf/xGUsuKOJoT9OJat73JsZwQ/GCACe
+PZTnHbGcQ7mnT1DR9m7EVuulG5AOH3ESQObtwJPrbNQvhsspYEXwwddCDsIN9jz
5KrxnbS+VAhaVAgIK/xao4UvGi7mQTbBw9ghHqFBDs2Nk7BtCzY=
=xUu+
-----END PGP SIGNATURE-----

--463vti2ltg2ex72b--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26B5E57D8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 03:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIVBLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 21:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIVBLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 21:11:50 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50049.outbound.protection.outlook.com [40.107.5.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24594CA0C;
        Wed, 21 Sep 2022 18:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpE4V+7Kx6qEwhb/32Y9oZXyNiHQ3SV1kNSjmkSXXle+S7vC3CcCxLOXFH8oTQS4/PQdXhUU3FbEz1pO+QXILDkpw2H0WcL84xtwXLbkJrb+ZJTiu5FxHFEp9Rkpi/CUBj3JDVtRjm4XgLtENJjsOZ4Tsy+mdnObELeEWMNmv4Uf58cCbbks/ZlKuC4aQ6iGWVli+WozRzOqycgak47rW5pbAqi4hwEk8CSUsLkf10JyX7Q/uOGZhSnu+zTiU544efoDQpou/z+AnVEIU3KZ5IF8/blMOXwGPg6JyMTkIEsaH66nu2zT276t4Yuso60z7kiwjNMbnqNLDSs8ED51ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrwnkemrR/YKQaFyjth2zbQCFDwhaaEEZmlUkTgHepo=;
 b=FT7hpANcjmiL57w4PW1ueRR8DxLyYqoyTSty9mIeS8fVP8/ywUjj8rG5vCFwGbnt4FNOQ3/6PCSokulTpq87V7oFZAX98P+XGRWULqLmN/4latvf5vb0jhTvNbjHcIt643/kX79iALycLyWtj1nswGCrxaN9/GBMNu4Zkw6osT21kIcZk3GnBYC7DVTQyjWY6+psqIPkHLwop/R8ysZu8nMFgnFfofQuK2yP5FUJ53bXsGINx0DiWVr2PRYDVWaGLDtHs9t8vLLNZJzX7SJ+WorGoi2//y4u4JCcyVuGsUiWPpzqQoNBTEy+5NLeM+AtVCgcUtU+gpHBNbkctCiBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrwnkemrR/YKQaFyjth2zbQCFDwhaaEEZmlUkTgHepo=;
 b=P+1Ev9cNCWGklELMAYB17DdjIrqVMITzVMqSJiEx3uZkvG2lUCp0LhZt79xWug6TMI8t70cB3FGEoOZme4AZ71V1nlv9l2JgPe2b/b/9VU+qyNCSnA9TUbTLb2Cq4DvnyDl3H/pD+2BIHLYnFIMQV9FyEsJcGnsowQnz6JJU5j8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8698.eurprd04.prod.outlook.com (2603:10a6:20b:43d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 01:11:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1eb:dcf:8fd7:867%5]) with mapi id 15.20.5654.018; Thu, 22 Sep 2022
 01:11:45 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: RE: [PATCH v1 1/1] remoteproc: qcom: Add sysfs entry to detect device
 shutdown
Thread-Topic: [PATCH v1 1/1] remoteproc: qcom: Add sysfs entry to detect
 device shutdown
Thread-Index: AQHYzEehbNqp+4WP5kC4mL0JhZ+SEa3qpRCw
Date:   Thu, 22 Sep 2022 01:11:44 +0000
Message-ID: <DU0PR04MB94171ADF7D72882F0B88AF78884E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <42d3ab9227ac3d299abcedbbdd68c86e1dd6acce.1663604826.git.quic_gokukris@quicinc.com>
In-Reply-To: <42d3ab9227ac3d299abcedbbdd68c86e1dd6acce.1663604826.git.quic_gokukris@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8698:EE_
x-ms-office365-filtering-correlation-id: 879076f6-b645-4fc5-68b6-08da9c376a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUTLYUX4qnIR64HlU4nVcYhBfk9majHo1WgqkT+0aHpif8cZ2ud7HUmHu9n5RIUB1qVy/G6HmWBbIxRVQPWvxoTe96LV1wzusznXVwOe3Fl1EEfKqFSRrzNS3cy9vlFV0GKzsKEOJ09+Jr5zMrjhBvEzW7Mk216pBj3oyFTUefYkqh9wuN15nxugRx4NFCqvAR/NxBqoI1jh0hnuNQWudZhy/qcLMYwVWl5qfrQBvbkn5h4HkpBwWTd23S7JWHjMKpjoUEMBL9jB4h/pBpPCn5JkKI//vX2BOLKl/U5EuA9FnOVRd6DLE8UaB3faP3H2T8i8X70Yr+Bg+BcH+qZtKidLtiCxoinqRbyulq5OzmlX5KjYmJPBnXuSI2Tmfs9oY9UQH1gZbyiGIEDb0AvJwqLT2Wnr+qVfend/ZZHQX+yTnM5uYhdb4dsSgMoWPaTjvaZFYZK4YulVVqi8fBcpcFmlYvPhoYsZLNHjzf6Ff/GAK6WWGdHmmzjqx5vClj7mZ68UiBvhYe6tvOzvulzADg0mUnjcxJZk/+4NNHBsAKFyMFtQuWnw9n6NrL6Q92d+Hrquiy7rqfV+Fd0DRpo2/v5etIOMq8PfW7D5lP9fvwws/ZmZ5zRZ+rdYaC+WFLn0d1VFNjplokqL9K9YukDguwScJ64keoxSwEk6w+e2zsNs9D7nVIwleDSSmXkpegrqcExTeVKdF9WtbrTgG908L9e0gPtdm7MgUAWjSmuNG3H3lMjcDTxCAw//HyyDJ5azmMn1dnhuXmpAuQBqbJamIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199015)(8676002)(110136005)(66556008)(55016003)(64756008)(478600001)(5660300002)(66946007)(66476007)(52536014)(8936002)(7416002)(66446008)(316002)(6506007)(54906003)(4326008)(76116006)(9686003)(71200400001)(26005)(2906002)(38070700005)(186003)(83380400001)(7696005)(86362001)(33656002)(41300700001)(44832011)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7mmgV2hLiF1Qg59d8VO1GLKcWQDf4NtQzURanDhXpBsrdRsI4yaicKhV2stB?=
 =?us-ascii?Q?NkSxnr0wFzjVhtxfFg7u1+zHW4zGiU4r1kdYhcRxr8eUfCeg/rG0Peu3H/pQ?=
 =?us-ascii?Q?0O234pE9gvBStlnFsZEfGsCuVgm636/EUahe67gYCAVcbUrYLD/Yw/X+LYnM?=
 =?us-ascii?Q?j4HMBD+WWGLM4CsI6XFAP/P04CM1NbvfQ1G45ISXEhIO4mcBGR2GLVU++EGM?=
 =?us-ascii?Q?oUyrADzPM/13frf1nSa5Zvufw1mkpZaQ8Z0TO73jt5sO/pwq2LDJuHqqLum9?=
 =?us-ascii?Q?6jnmycq0leOzSA4ldYf/Oos/xxoLgHONylbB9vRbvy/Tz+l0LHtGcVLJkynB?=
 =?us-ascii?Q?IFh2b8PRU73aF61Ok6/r44t4kT2Buo2toIjGoUXwjkYxKTQfap+UNuUpq3Cy?=
 =?us-ascii?Q?ugmiceDAg6I7UXkH0jhpz4w6INJCTU2kfeoj1SmxnBGtLNS2JyOwqFyfruhT?=
 =?us-ascii?Q?Srtd6Doh0TrBmBoigwBgaseJ3TECZjvHiNjxsZUEOyEorN/0s01JfIqEbrpi?=
 =?us-ascii?Q?5rL1VsA9O49/HuMaG5hDKPYwIAiVbiy3h7VwHvxgRHUUNQROFssIyXHjXKFm?=
 =?us-ascii?Q?yd1V+cQQyfSenuRlu/btp8Pr0y7GDGOgC4LUCssik5Ucs2BmMIb5ea2PtxP6?=
 =?us-ascii?Q?OJYzBCJTtuqeGP5e3tKGE7/Oe1JNJcnPY1uCUdxkDjPsktNGcwMdI6bDGOZK?=
 =?us-ascii?Q?MemEU3P/5fsL2M8tz04NyBntH91+y2GD4pYe9fk2MOrsE7IPkZdIdcdScTw2?=
 =?us-ascii?Q?oWfL3Dskd+2FLeM8bgbENv14F1n7iUy8aP288Zl0orEJIzBg30A17tni5aln?=
 =?us-ascii?Q?Nn+FVkokBm302GHSGZGfhrnubegXkn9jTlMdHnHu2ovEYO4bOXbQRXzkR/zb?=
 =?us-ascii?Q?yIQpxAqrxt0dWfAln5jlf9yyKjhs+0iYSDSnJMcuRdWjw86eDqWdf2K/HU3h?=
 =?us-ascii?Q?baQr+R6U3vUd8vqgm3CbvcF0BeJ0PaibnPtmdKeuRH2WNwXfs5zuCVmzrx9a?=
 =?us-ascii?Q?0i62fBXEc2QSvUrDn3yP4LHEf3VPK5mdArmTGqCtHsReMjN3UwnOsHJvvPh5?=
 =?us-ascii?Q?qXPbDO/zEdPO3iDGR7HdIKrv+Op8b5+m9FW0WEgzRztr13xcVFH1kQ7Ki5F1?=
 =?us-ascii?Q?Hsf9fbaQEiDvV2O2s4lzCvLw1LF2cfX9g0FHh/7RH4YtR/gTct1m/ge6NAg4?=
 =?us-ascii?Q?CW/An9t2simhgAwJvifYQlY7/lZs/xhg/D7+y4tKaLuwS/h5QS103X0Dro0i?=
 =?us-ascii?Q?3rnvnrc7SHs90mkJFqWd3YUc9E664HEui4SeZ0pvGtYUYmQ58liKRauy70X8?=
 =?us-ascii?Q?oXbTF/WvYgYrsoQmJVqB1646ZuqetBlhbaLPGIiNI3FYXqQ1Yt6673aqtPkx?=
 =?us-ascii?Q?t7PDeneV5Li2PuogUrEeSa3R9AHGZY18LRzDIY+0aZHn5qLtPAUFEyLL0YOG?=
 =?us-ascii?Q?7sGAwBXh9F05TkpXjX8DKeFtPLkjZ9sA9TlGnaSD61OJwbxXDEtpGvYInu7o?=
 =?us-ascii?Q?9LNhMGqKA2sh+La2YPh3sExILgNcubMmeRaJyjmwx+Y8tVOq1XkwYDm1J6Mi?=
 =?us-ascii?Q?GzqgjoIvo/StufQJIk8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879076f6-b645-4fc5-68b6-08da9c376a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 01:11:44.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R951k6Mb1v47/K7kZRpRSJtaVlfL+Ok9VYZSWLoPbnc86eJeo0YYwMDQ++FGRyZxaW2rc208R3daGBteQ72iew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8698
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gokul,

> Subject: [PATCH v1 1/1] remoteproc: qcom: Add sysfs entry to detect devic=
e
> shutdown
>=20
> This change adds a sysfs entry which indicates whether the device is bein=
g
> shutdown to the qcom remoteproc drivers. This is going to be used in the
> following patches.

I have no knowledge of qcom platform, just a few generic comments:

I think it would be better if you post a link to give people a full picture=
 on how
this going to work.

>=20
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> ---
>  drivers/remoteproc/qcom_common.c | 58
> ++++++++++++++++++++++++++++++++++++++++
>  drivers/remoteproc/qcom_common.h |  1 +
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/drivers/remoteproc/qcom_common.c
> b/drivers/remoteproc/qcom_common.c
> index 020349f..7959e96 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -87,9 +87,32 @@ struct qcom_ssr_subsystem {
>  	struct list_head list;
>  };
>=20
> +static struct kobject *sysfs_kobject;
> +bool qcom_device_shutdown_in_progress;
> +EXPORT_SYMBOL(qcom_device_shutdown_in_progress);
> +
>  static LIST_HEAD(qcom_ssr_subsystem_list);
>  static DEFINE_MUTEX(qcom_ssr_subsys_lock);
>=20
> +static const char * const ssr_timeout_msg =3D "srcu notifier chain for
> +%s:%s taking too long";

I not see this variable is being used anywhere.

> +
> +static ssize_t qcom_rproc_shutdown_request_store(struct kobject *kobj,
> struct kobj_attribute *attr,
> +						 const char *buf, size_t
> count)
> +{
> +	bool val;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	qcom_device_shutdown_in_progress =3D val;
> +	pr_info("qcom rproc: Device shutdown requested: %s\n", val ?
> "true" : "false");

This is a sysfs write operation, how does it matter with device shutdown
in progress?

> +	return count;
> +}
> +static struct kobj_attribute shutdown_requested_attr =3D
> __ATTR(shutdown_in_progress, 0220, NULL,

How about DEVICE_ATTR_WO, but seems you use 0220, the generic
marco use 0200.

> +
> qcom_rproc_shutdown_request_store);
> +
>  static void qcom_minidump_cleanup(struct rproc *rproc)  {
>  	struct rproc_dump_segment *entry, *tmp; @@ -505,5 +528,40 @@
> void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr
> *ssr)  }  EXPORT_SYMBOL_GPL(qcom_remove_ssr_subdev);
>=20
> +static int __init qcom_common_init(void) {
> +	int ret =3D 0;
> +
> +	qcom_device_shutdown_in_progress =3D false;
> +
> +	sysfs_kobject =3D kobject_create_and_add("qcom_rproc",
> kernel_kobj);
> +	if (!sysfs_kobject) {
> +		pr_err("qcom rproc: failed to create sysfs kobject\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D sysfs_create_file(sysfs_kobject,
> &shutdown_requested_attr.attr);
> +	if (ret) {
> +		pr_err("qcom rproc: failed to create sysfs file\n");
> +		goto remove_kobject;
> +	}
> +
> +	return 0;
> +
> +	sysfs_remove_file(sysfs_kobject, &shutdown_requested_attr.attr);
> +remove_kobject:
> +	kobject_put(sysfs_kobject);
> +	return ret;
> +
> +}
> +module_init(qcom_common_init);
> +
> +static void __exit qcom_common_exit(void) {
> +	sysfs_remove_file(sysfs_kobject, &shutdown_requested_attr.attr);
> +	kobject_put(sysfs_kobject);
> +}
> +module_exit(qcom_common_exit);
> +
>  MODULE_DESCRIPTION("Qualcomm Remoteproc helper driver");
> MODULE_LICENSE("GPL v2");

As I recall, checkpatch would report GPL is enough, no need v2.

Regards,
Peng.

 diff --git
> a/drivers/remoteproc/qcom_common.h
> b/drivers/remoteproc/qcom_common.h
> index c35adf7..90b79ce 100644
> --- a/drivers/remoteproc/qcom_common.h
> +++ b/drivers/remoteproc/qcom_common.h
> @@ -34,6 +34,7 @@ struct qcom_rproc_ssr {  };
>=20
>  void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
> +extern bool qcom_device_shutdown_in_progress;
>=20
>  void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink
> *glink,
>  			   const char *ssr_name);
> --
> 2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D344B6EFA94
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 21:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjDZTC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238579AbjDZTCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 15:02:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A88483E7;
        Wed, 26 Apr 2023 12:02:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2vgJCh8LAAZ8AM98UaHOw1QlK2dlK20xfWihCbIPMb+dgQQePb6nka2umrWZAVIG3aw8/mQPdyc3ZTBlpoS5YzO+FiBKy8wk1hxk/CYsSDPGNKFQjEOGSeZRTWuZAzzrxhbCoSmMF/fFPDXMdyTTzaWZ0OPbF8NoiVHtKiGYbMjGex8NCNq4mo2K62tRFzBLttDz/rI4q4I1YDsD7TagdOncLn3RlAw2DLYbK34wy4keyiZvMlTDJYp8EN23CpdJZy8CreZg/sRbtA4V25yL2miQ2hjFX4lyXITx5dSb0uBIX/MXK9b1RANiknS51753sU5t5iphdekhXFmruQDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdPOE9eG+Fo4RkN/1ZdLHNJBvN+dLzZxafaffh8/7rk=;
 b=HbPgXfA2oqFt2UXjdjs9XYq5qZ5ojgLs4nxekKW1rNGfc6JtCvHJEpKhvVGlFVnL+8qtThctZMzJzE20oH+Q7IjgYhstjHuJVvT4MOCxoC/w/xHi+a7RYgvVqQXxmAdOIg6d2rPaVMKF2zIMvAseIi1XHAyDdSrTAcnt3UzkD73f5qdLnW4KZwa9LLNF3kXSDGS9TaptUm1qgIS+85D/1G1ycGCrMJxtxXM2Y4mJWz+UJQXp7Nb5PGt1T787I0pKtmWLComNTHHgrX6C3ho0TuGv8+Ea4DCU+JHtscR1PWc9s4o6C0ldjtBYWRbTAiXcLGinNPitoIvOdWk1df2kfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdPOE9eG+Fo4RkN/1ZdLHNJBvN+dLzZxafaffh8/7rk=;
 b=B1zmdbFHzgEfur3AnXENHmI2xhtdBx+QpTgVqvoHyFrwsQiFnbrEzCz949thctb1U3rMzVOEeKZMRaPbK+wIq7/zftBwjvYN2gUxbgvdOw+yVoIv/D+RolgpBgLRKXDi4y8lKFZNhQqh0UP41O5wAGM/dk/MKqlslPPpAql04m4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB5005.namprd12.prod.outlook.com (2603:10b6:5:1be::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 19:02:21 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 19:02:21 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jonathan Singer <jes965@nyu.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Jorge Lopez <jorge.lopez2@hp.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: [PATCH v3 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Thread-Topic: [PATCH v3 1/2] platform/x86: hp-wmi: Add HP WMI camera switch
Thread-Index: AQHZeG/08X7EDR9JD0uGfRALEFMkoa898k+w
Date:   Wed, 26 Apr 2023 19:02:21 +0000
Message-ID: <MN0PR12MB6101510EDF6D0904E602A3F9E2659@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230426184852.2100-1-jes965@nyu.edu>
In-Reply-To: <20230426184852.2100-1-jes965@nyu.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-26T19:02:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1a87c4b6-70e1-44f9-b0ec-fe3e02a30ed8;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-04-26T19:02:20Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 4b98c472-f5a7-46d3-88e0-1832ab49e7b8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB5005:EE_
x-ms-office365-filtering-correlation-id: fa9f144e-4a5d-49ae-d64f-08db4688c3d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Ezi6XIVLRIgEP3KUft2VeVMsayGIcy+/12lhW7wZs0qEXH9HDKEXgwoojE1lrqqzH+dq7X8CSkr/IdLuKjY/o5sfDSTn6APTnhwIj4OF93SHqacWsORBD1dgOyRiK0fA2Kd4/FrfaAXNqf2+sz3QCljzrzk6DdU/ZHEv9+rfD5mO1aQcmpvszNa3QJDPGD33JUGjY+hFvoUDYGlgdRm+TC1yljM8Q8oKFXovu3qEUMOJPmeCr0yujtAPQqQUk+lQEyRr86QfFi9f1in8EQcFiHfgJBdfVYaNSoOMtHvqL4yl5EIYlS0ukhbnopWN/J8RCmu+eObrch/A2HSXo54/ZaFrJxJ5S1uEfJbG4SQhds1MaVHUHJ7hgNith684zmgfzZnglcZbMjj+6O/rUW62NkxJEAtwDS6bJQ4Lp0po7uIiPYXBYpo2v/KaIfbiqF5KSCD1qB/9zCfHYLNJezBVuEFEeu0rnPqPgMerpep/GvI8/0NDzRXtDRho4sFrJR51fijCPKe4uXRgt+KW/aU0Wd0nvRsuzMEFcmr1GofbXQOLgDVq6zBu9OqoTzYs+YMUI7myafcyoneXDnhW1Kd3CS0KwfuwUWXwsA0aLitdYeK7Lqy3QfI2eK6/B/ZnjME
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(122000001)(71200400001)(186003)(478600001)(7696005)(110136005)(54906003)(26005)(6506007)(9686003)(316002)(41300700001)(8936002)(8676002)(86362001)(4326008)(64756008)(5660300002)(66556008)(52536014)(66946007)(33656002)(66446008)(66476007)(76116006)(2906002)(38100700002)(38070700005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YaDTaqthpm52M6NSs1CDYHNHUFZgaEp5oes7cw1CzfQu3nFYnYjWenrsbmx0?=
 =?us-ascii?Q?JRPyusRdHxGkjlWqgrJ/9GUvGQMlJTCgNoKweOBRErpgi/pj7gCw09QdYy0m?=
 =?us-ascii?Q?ww5UMWVMUKFAIKlpp9vPTVEzkSO03KthjmqEI6nKYIQIBniXIFoAc6sl9w96?=
 =?us-ascii?Q?hLMDU0DFvM3vSI8hWt8v2ylSzWTvbvYXqlsaW6aGlUwHdT/wDaiC91p7/dL9?=
 =?us-ascii?Q?dzW0yQ0zJ/ESLfbQ5ESg5bda2N4HC7nN6lw3Pk04iSxPG8/0OYJMbb+/e5T/?=
 =?us-ascii?Q?XSeumDSe3yrIXglCC4bS661X28BUoFFDOq64IJKokblUTq+kj/wjbEoDDyR4?=
 =?us-ascii?Q?1WezpaI6GQGvkLVR0yBV/mv+fZLC6PjZRa+jk0HhxZiyGSpPbSwibBvYUUWh?=
 =?us-ascii?Q?EW/2ZkkiK9v9RFNmes4TpDXKEOdrwgG9vS2CTW9JVpowlxE9fBvMP3blLp4q?=
 =?us-ascii?Q?xfIyiXSZgMC3x7bF96EiV0dNH+aXeDqa54iXMbFXqPKvcC42F+hqqZ5+udHl?=
 =?us-ascii?Q?Xd9GS4/1vAE4F9NyXp5XFVrsJdfXuqOIZ8jbY5bUm1c3K8X6vHuaoLPjkPhD?=
 =?us-ascii?Q?G8kl38gqcAO3RytDV+yQiY96hIkPUmFsBveq/aUTa58S5fRDD2uFcK7N6lL9?=
 =?us-ascii?Q?8XIsitqtSiDu96yHu3NvF0glZ1yD+25yJ4eyq5NNMugIgzNJJ9upOrCiej77?=
 =?us-ascii?Q?I9F3uZHG+zkYA25PVRG6zb4BIOhgDXLqw9UIaM2lD17gZSN5a+pFfDeCl4dp?=
 =?us-ascii?Q?gIJJ7+iQBhTZ1z8byz2VeFuqcSzwiKWruyoO4KDGVnXmtIlt+6cP6OL7ab73?=
 =?us-ascii?Q?uZZVjeqzMIZhQ0T3e81dd13u5L6Dlz+Vc3GmcvZAhMhBDJtCNugoTD02lPgT?=
 =?us-ascii?Q?XOPl73A79MuSjVAPY0+C8h5o8bLUKQChSRiIR0qUkdzPCUaZAjKs4xGLpChL?=
 =?us-ascii?Q?f+LA+GIPvnEWwVdvn0R0Ek3BzGGl1h2nuL41ts98uUWSGw75tiUYeYOel9vu?=
 =?us-ascii?Q?5C8RtBelHq1gfIwS1VebIv13w1g5RiZ93A+VPDqejsn0TA+JNnlzDQj614C+?=
 =?us-ascii?Q?7w/JFUullJ3E8dBcuDjAUqpqc4261p3vzE3EoZZBhej9xhCDErKNy6t42kbV?=
 =?us-ascii?Q?bjfZygW0tsXKbV95+RTvKYMAFSOJdWHXkxBdWEAg11CwOA9HwhTGyjSZcj7O?=
 =?us-ascii?Q?VZazqD3oDjYBYEUCEzXZwsvwN6QhGYHcxK8iAwP7X8XW48dQs0wFhmf9nAh4?=
 =?us-ascii?Q?PrHr13X2abRqN/2yMMS0k0lHnrRnvkzYWecSsjkwhU5m7OB7LLAEhHoZSljJ?=
 =?us-ascii?Q?0Rcb+CeIyKLlUT7AfI1hkazBMUl1kWgaUE6TC8RNa6zBP0cw6NJiZm23ZDaz?=
 =?us-ascii?Q?UVXgTLu2MeUKtKcXIaHlDjQoGiFHjxrbCMfLRser5qHj9DTxKRwtzMmkLEyp?=
 =?us-ascii?Q?3qAqT+U7xYsAczDzHC7LBqBkUf81PYIx5YxTnj5dGIjpPyc+mWjZlUZbwurP?=
 =?us-ascii?Q?qDmpwVuPGZ7wCPQHJx145Oe+Hh8qQpPUiNkFe1Mh1KsiBV7SnGuwPZhBNWS/?=
 =?us-ascii?Q?X8n1HMUXBk6ifRVfeiw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9f144e-4a5d-49ae-d64f-08db4688c3d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 19:02:21.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgAkeikfS/3Q9uADCOdfqOckzvo9XX/t/LCCrsGDUt8W24BQQ6OuH9VjBtbInpFvL9SpGnAqxjwN3dztajZkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Public]

> Previously, when the camera toggle switch was hit, the hp-wmi driver
> would report an invalid event code. By adding a case for that in the
> event handling switch statement we can eliminate that error code and
> enable a framework for potential further kernel handling of that key.
> This change was tested on my HP Envy x360 15-ey0023dx laptop, but it
> would likely work for any HP laptop with a camera toggle button. Now
> we emit an SW_CAMERA_LENS_COVER event, on a device that gets created
> on the first such event so as to not report incorrectly the state of
> the camera shutter before we can know its state.
>=20
> Signed-off-by: Jonathan Singer <jes965@nyu.edu>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> V2 changes: Added SW_CAMERA_LENS_COVER switch event
> V3 changes: removed input dev sync, changed pr_info to pr_err/pr_warn
>=20
>  drivers/platform/x86/hp/hp-wmi.c | 46
> ++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/drivers/platform/x86/hp/hp-wmi.c
> b/drivers/platform/x86/hp/hp-wmi.c
> index 873f59c3e280..18d40270aa0d 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_PEAKSHIFT_PERIOD		=3D 0x0F,
>  	HPWMI_BATTERY_CHARGE_PERIOD	=3D 0x10,
>  	HPWMI_SANITIZATION_MODE		=3D 0x17,
> +	HPWMI_CAMERA_TOGGLE		=3D 0x1A,
>  	HPWMI_OMEN_KEY			=3D 0x1D,
>  	HPWMI_SMART_EXPERIENCE_APP	=3D 0x21,
>  };
> @@ -228,6 +229,7 @@ static const struct key_entry hp_wmi_keymap[] =3D {
>  };
>=20
>  static struct input_dev *hp_wmi_input_dev;
> +static struct input_dev *camera_shutter_input_dev;
>  static struct platform_device *hp_wmi_platform_dev;
>  static struct platform_profile_handler platform_profile_handler;
>  static bool platform_profile_support;
> @@ -739,6 +741,33 @@ static ssize_t postcode_store(struct device *dev,
> struct device_attribute *attr,
>  	return count;
>  }
>=20
> +static int camera_shutter_input_setup(void)
> +{
> +	int err;
> +
> +	camera_shutter_input_dev =3D input_allocate_device();
> +	if (!camera_shutter_input_dev)
> +		return -ENOMEM;
> +
> +	camera_shutter_input_dev->name =3D "HP WMI camera shutter";
> +	camera_shutter_input_dev->phys =3D "wmi/input1";
> +	camera_shutter_input_dev->id.bustype =3D BUS_HOST;
> +
> +	__set_bit(EV_SW, camera_shutter_input_dev->evbit);
> +	__set_bit(SW_CAMERA_LENS_COVER, camera_shutter_input_dev-
> >swbit);
> +
> +	err =3D input_register_device(camera_shutter_input_dev);
> +	if (err)
> +		goto err_free_dev;
> +
> +	return 0;
> +
> + err_free_dev:
> +	input_free_device(camera_shutter_input_dev);
> +	camera_shutter_input_dev =3D NULL;
> +	return err;
> +}
> +
>  static DEVICE_ATTR_RO(display);
>  static DEVICE_ATTR_RO(hddtemp);
>  static DEVICE_ATTR_RW(als);
> @@ -866,6 +895,20 @@ static void hp_wmi_notify(u32 value, void *context)
>  		break;
>  	case HPWMI_SANITIZATION_MODE:
>  		break;
> +	case HPWMI_CAMERA_TOGGLE:
> +		if (!camera_shutter_input_dev)
> +			if (camera_shutter_input_setup()) {
> +				pr_err("Failed to setup camera shutter input
> device\n");
> +				break;
> +			}
> +		if (event_data =3D=3D 0xff)
> +			input_report_switch(camera_shutter_input_dev,
> SW_CAMERA_LENS_COVER, 1);
> +		else if (event_data =3D=3D 0xfe)
> +			input_report_switch(camera_shutter_input_dev,
> SW_CAMERA_LENS_COVER, 0);
> +		else
> +			pr_warn("Unknown camera shutter state - 0x%x\n",
> event_data);
> +		input_sync(camera_shutter_input_dev);
> +		break;
>  	case HPWMI_SMART_EXPERIENCE_APP:
>  		break;
>  	default:
> @@ -1564,6 +1607,9 @@ static void __exit hp_wmi_exit(void)
>  	if (wmi_has_guid(HPWMI_EVENT_GUID))
>  		hp_wmi_input_destroy();
>=20
> +	if (camera_shutter_input_dev)
> +		input_unregister_device(camera_shutter_input_dev);
> +
>  	if (hp_wmi_platform_dev) {
>  		platform_device_unregister(hp_wmi_platform_dev);
>  		platform_driver_unregister(&hp_wmi_driver);
> --
> 2.40.0

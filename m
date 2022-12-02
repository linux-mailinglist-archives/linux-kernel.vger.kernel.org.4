Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF0640EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 21:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbiLBUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 15:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLBUIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 15:08:31 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3279E94922;
        Fri,  2 Dec 2022 12:08:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa9EuMK/EgYi01bOXqDVw9RRmjPcK7eS4z71XM1/9992scbm022RAZw4ruyvewyEcirazBD+Ntue8dn6foDSis2WswI/gLhwTJydrHrXWkMfF3OLt61thzwHaKJn2+h8WsAi2E5fVuIxju0RL60flndQgIo/oCcdXWv8HSswB+mm9TF9DDsYc6ToDyR9C2sPJZYC+/WLrnS8eL0sWFYrmE8NK0ITK8sNfVgOkn6of8cj/6eIZBc4O/cqHscz3EMM5M4f+piNVZtGcJJAOhBN2SMIRR9W8qDrx1s+oFl9vauCCgtk7+zp4GeS5hX6xd0PT+pniDJHTZJX533Y5tUWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cl7S9wVVFdAAT6WPdM38C0d6oGTLObKoAQJQhti6iWw=;
 b=STYesy/wPJbZqdQEL/qUIeiM/OJXuZwa3q/AKJXcen8ZwDTd0JKik2B1UnK/dcXFgjWZUuqy8u6CXuZtA+urMZihJGP+dWEJTMofL7NwywQumyOUoAppksd7skb3ll4+3eCmTtnHc12p9gnVLwJrAOiG6o0i3+VSHUbhl2NyVCo5uBE6OeP+J2Dx3qmleugmaCa8GfhQGpb6LoN4/G/D+b9vYnPXRO6gbPDWBbR781TVumhhx1fMM1X4NH4kSVz8iQc97jNnG+UQPBM+shX2NltLdelpzWTkW8oa2dChq2qhXxnIc3dmCHD4nOf7D6J8hoVjee9ebE2s+gVMPbCnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cl7S9wVVFdAAT6WPdM38C0d6oGTLObKoAQJQhti6iWw=;
 b=g8puoceeTtsdZxKa84FhJJn9J+u4kzjKMh6AVpP9WGtJeVc020uY0kCKr6vIWPPG+xxgkpK3uRS7TdEL+u659h/IDQn3f8ZFVukbfO5IUS1LbzuBIAno605qLeiYzDPeKy2Ts5ntood1bs7hRqu8bikDtSegfME4lWiQcaBnBz5MOhWm2BrVUmXWaj4/XpQwq9wgwfdriHjw7XWZcWVC7qtLIlZaK2UHVZAL+UN3gpfhU1fZwQsDnmti0nkK3akqMUZdCipH6bjbsazoYCSrXuFJmMn9RO7OXgWNWT6JCQS7Hep49VldLRALcNhI7gUgazqX/PYWMl0blm5sxU29NA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by DM4PR12MB6637.namprd12.prod.outlook.com (2603:10b6:8:bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 20:08:27 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd39:3377:9967:5b10]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::fd39:3377:9967:5b10%4]) with mapi id 15.20.5857.023; Fri, 2 Dec 2022
 20:08:27 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Asmaa Mnebhi <asmaa@nvidia.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v1 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Topic: [PATCH v1 0/2] Add NVIDIA BlueField-3 GPIO driver and pin
 controller
Thread-Index: AQHY6WB/328y28TN9keN4WyugN82065bQNew
Date:   Fri, 2 Dec 2022 20:08:27 +0000
Message-ID: <CH2PR12MB389596CA10C6B487EA7A0B5BD7179@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20221026172843.27236-1-asmaa@nvidia.com>
In-Reply-To: <20221026172843.27236-1-asmaa@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|DM4PR12MB6637:EE_
x-ms-office365-filtering-correlation-id: fa852c84-633d-4e3b-5c4b-08dad4a0f975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFn3vLKU1iqXjDFiLI6FxkJygWCEVKHK28kXbEHzNmxnH7ftC1c8M5dYMmbkgBvaW4RdxmRKGDc+Rw7X+n94ShAEobnAIvug6dTcBnF2JDsK3Q0KQ0CpDVZkS/9oKAFqKpYEq8lGXW3zekbqfu8VUQl8L/CG2Edg5SbYsrNpbbNFBJ/EodCUoe6M++bduvuK8N+EnRXguywDY/uPdPhVJfaSkqdaNekJzvoZ6HlXz8trsEmFOPGwfvnO+R7Zz2ozFPUhlDe7HxztnWxuGot/cmXhP7FD3kUbXYNu9IKEDxrhutvTyDWhI6wNnYUS1Ju6Axg72A8Z1atW0+U317R0a1QsL+udy/0sNn3AM1xCS8kc8gpO/Ghv4pr5PqXbzeNkYsO5JvkJ6uWpYMPEIdD7WNFrsK8zr9e102UD5jsirIsbRBbv48MYyEzhHJJuJCfFk74gNSYUv3WoklzG957NHm77RxUVj1uKH0H/U6bp00NmOvINbOnNbXpnkIQtk42SFOYbE3YkBLgVhoUCFcXlMEpsPxAR5KH57mN+hnKXYNr2Wu4LWD9ZrtzN2bQOg+Q/yQCIgI+dlnD4wXKtATbz0G8sHVVVvkqw1ZyBN5KIBpuCFh3jC0qmJM9TZa02ijThwX29vfgpCRcn/32VcI9MywPfc5sPdkJGlGis3+uq6LAU2gjjiEUNAH1jXl9XKOcW4MkgK+4LpjzcbJQsk+1jig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199015)(86362001)(55016003)(186003)(122000001)(38100700002)(83380400001)(8936002)(38070700005)(66446008)(7696005)(53546011)(26005)(52536014)(5660300002)(6506007)(9686003)(64756008)(8676002)(110136005)(66556008)(76116006)(66946007)(71200400001)(478600001)(2906002)(41300700001)(66476007)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?InO2hYT+5Gua9HLdzyDqBmBpsRN/5q51qBL64X6VfY53iOigZBEAPnwCYOZf?=
 =?us-ascii?Q?a9gWNNt5Obmi6T+6X1LOUDLkuyot037zo60FUA+7tZzTpC/IVs4JrRI4UZXU?=
 =?us-ascii?Q?E6DXLWy5xKzu1Lo4ng9ewHF3I5MgPOWQ8dCo+eRyb/PtFxqyni31HC7O9Ypb?=
 =?us-ascii?Q?mkUwPiG00EgK67UkzOcyeXXLreKR7mZ208jkE2VnsmTYslwkK1abjnGrQoHK?=
 =?us-ascii?Q?KnVV9l0G7JV7DcCI5mpnO8PqKKYWYjKPREsXjdC0dCJVOA92SAFJ0daXsISK?=
 =?us-ascii?Q?jubQT1TGmKv9AqqZkMLQqeknZ4ZNlYp2re/48i4cryJmrE87DLIkH+z0FieS?=
 =?us-ascii?Q?Vx8Ad9BElr8Qb0KrZAovDLRxw6zYTAunREozez6pLj72I8unoIFS5XFaBzJs?=
 =?us-ascii?Q?D4OuiC5wboEySYFeicsOOhdLe9cBA7brAGBz+3cH1Zqq2FY1bGcPSyyuMnXv?=
 =?us-ascii?Q?/24EDdT0WizRb0xU6rkNNKWtD73Hlk3sLTM2ikMKiVMpizQJz41iJbJpm0Do?=
 =?us-ascii?Q?VNgBhjFERuJdqYHqastYJmZXuH9qnIiBl5alwvLGDgfVzuekS8v6XnIkJwz7?=
 =?us-ascii?Q?aAO4J5R/kqPL8tgTYcFXNAk7VDb3XG6yEzAOTGmVWr5t2XlKgbUyaztACA5j?=
 =?us-ascii?Q?KZfJCJxRafNkmXyPv8KGKCGxs784NFHfjz/Aa+EaJU0hJXkulgJF7V9RWMOM?=
 =?us-ascii?Q?w8qUDpZX33sTYPKb1DfWNSjJ92TwKHll0hNoaVrxLLdtD+26rp+sj7EJZQmF?=
 =?us-ascii?Q?k+3yp7p0Z4fEbg+3PMESjeoh/JlR/LCuNZ/RkV76F56o8TDbz9+tbiUCxUbY?=
 =?us-ascii?Q?n48QwHbJtE9ejgYRB6PiZiGe+lU5+/On/YaSSjeb4hY3FbbafC034VERlyup?=
 =?us-ascii?Q?emEkEglyzRF0MNtqOM9Y1/kVhiY2VSwL+8eegYsxolDk0zFfFxmPIZe3ZgDN?=
 =?us-ascii?Q?Bm8puwiqX8XuUp12jX1zuhXsTiV9P6NkitVscN6t8qG8palWQDvH/Zz/iZvx?=
 =?us-ascii?Q?Mvkn6b0oxZN0a/R2YY36gtlJ+BKoe7aUQh6imA7oOej8c5Ve2Om4ioLkHWPX?=
 =?us-ascii?Q?RxGPeP5ZfwjVNhi25Yr+gYFcOsQydus9i3uvNWZaHeO5maFOqpoLmaCJe8Ku?=
 =?us-ascii?Q?kMef9Il5dpM4RCRzhR5UwMcSpbfnAaG3TR1GKLF0MQ/tEA4cN8h4i8V0PnSc?=
 =?us-ascii?Q?YcyWC4RT9BtIa00xZW3jDLY0ZgGUF+ZkBe3gRL4zowIU1kJrwmcC85zodNFF?=
 =?us-ascii?Q?UHlz+toD9kxnaYCi9tnAU9xFRwYjuaUvC0g2f4knGgOnBdolTE8+vEwQL41C?=
 =?us-ascii?Q?ptyHUOvBjYaHWiWEBEG+hI12OyQYWERBN7jqutd9HrnQCcq+7SgVPOTMLL6q?=
 =?us-ascii?Q?jXaE3Z7EvvT84GpJcozh7RyJRCuXJHj50/ykt0gZpyHUAE1Jx9bDkfR1kSBf?=
 =?us-ascii?Q?Fx0gxLcOJUCtE/BkbEXz1MuwYJUV2PnlQcZurJnXLxPntdKAyI8vdWjjLgUg?=
 =?us-ascii?Q?eQjIjSn2tnVd/fDlmdhHgqjnoqkw7KZUrMzWTPldDWOUObNQ1PYZgfR/Vh5d?=
 =?us-ascii?Q?AaNNXlkpy+LZ3sg+IsI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa852c84-633d-4e3b-5c4b-08dad4a0f975
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 20:08:27.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xj+i/WCXdH1wwCQ40PMn1o/oMKQAM9eOznj5dVZ6twtCKAHelrozybMPuYGlUkUH8k5JqCyBbChk+q5LdE2mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6637
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you please review this patch?

Thanks.
Asmaa

-----Original Message-----
From: Asmaa Mnebhi <asmaa@nvidia.com>=20
Sent: Wednesday, October 26, 2022 1:29 PM
To: linus.walleij@linaro.org; linux-gpio@vger.kernel.org; linux-kernel@vger=
.kernel.org; andy.shevchenko@gmail.com; bgolaszewski@baylibre.com; linux-ac=
pi@vger.kernel.org
Cc: Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v1 0/2] Add NVIDIA BlueField-3 GPIO driver and pin controll=
er
Importance: High

This series of patches addresses maintainers' comments from a previous patc=
h which supported the GPIO driver for BlueField-3 SoC:
"[PATCH v1 1/1] Add driver for Mellanox BlueField-3 GPIO controller"
Instead of creating v2 for that patch, I am creating a new series starting =
patch v1 because there are 2 drivers involved.

It was suggested to follow the linux gpio standards, and separate the pin c=
ontroller functionality from the gpio functionality.
Instead of creating a followup v2 patch, I am creating a new series because=
 there are 2 drivers (2 patches) involved now:
1) NVIDIA BlueField-3 GPIO driver as front end
2) NVIDIA BlueField-3 pin controller as back end

Moved the FW_CONTROL_CLEAR/SET code to the pin controller so that there are=
 2 GPIO mux selectors:
1) default hardware functionality
2) gpio functionality where software can control the GPIO value when
   the direction is set to output.

Removed support to the GPIO sysfs since its use is deprecated and risky.
Instead, used libgpiod to test this code.

Asmaa Mnebhi (2):
  Support NVIDIA BlueField-3 GPIO controller
  Support NVIDIA BlueField-3 pinctrl driver

 drivers/gpio/Kconfig            |   7 +
 drivers/gpio/Makefile           |   1 +
 drivers/gpio/gpio-mlxbf3.c      | 314 ++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig         |   9 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 353 ++++++++++++++++++++++++++++++++
 6 files changed, 685 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c  create mode 100644 drivers/=
pinctrl/pinctrl-mlxbf.c

--
2.30.1


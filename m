Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80575E7302
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIWEgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIWEgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:36:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F23122627;
        Thu, 22 Sep 2022 21:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3LrXavL/FTvIcNIdrzx9G4hUuLC92beCckK2S90xQxwNUiXWAkge0rYd44zDN1oUPOxVnXHWMBF1pzy9JlaGrcMJXW9dARCn0FfMknGWdNjfjFhWTodkn+3kzMJ3LPnnpN3DxeFl5lNP1tiFLgotGT4RkYo0xlo00snH5MpkM8HY2HBTyOunxExOriY5XjfNyLm7SkQObSDBFDDlN5QX7/XJ3DCnePI1VQI1NZEsnv+8ry0QfItj1fQDfoIHlaDF62iPlmc/qUccn88BatFJ3mxOsMtgUC/9eYZJw84TQcjL2Sv8EWGb66kwY2uJIwFHOyvKrr7AZsmA4jqAj+5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KG6TI1oWpRxtDa916wlrbd3LTVsNr5lSqXqFSz5zRYU=;
 b=Bq+coTEUdSc9WOS5BAXjiZbABXip34bRhfL5zD5i9DwaWinpqoguKqGYcDLWXOQmzYukKPAoUlMzDpm74OdjM0JBel3EUmpHxOiWEaQhdwX3rdYssAemo5KT9JWZDzUYSiz2d8MB+INq7tDlufOGmruLjuAVGwNdPue2g6YJ3aLvOGWpgpXQ+iOEx/xo/NX4+KD49+v+0iIsjootF6P7UGUzc2HrbLN7sNkjFeeDSQksQ/EA4zVV/Gd39AWPLHQtUh2YocmvePJwvKZpv/YQSqbx3ECXAlyafSksADuIIFyhGYTPHYr+w8Cwjz83Ftisshhqp3V4icwIfWR20VrAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KG6TI1oWpRxtDa916wlrbd3LTVsNr5lSqXqFSz5zRYU=;
 b=shO5MN7Ba2P9KpFFhGKuGD51lA+B8J6Pu5y/Qx8Kp1yt4gdsJDkIVojyvzsHAF6w4rXY6Kjnym41opZDBiYdK+O8oOCfFWMSqR1NbpeqM5yZpN/suXqnIqHZw+aw3D1aW2qLmN/FkpbOAN3M8R/mVVLh7jg1km8NPyPpuqVdjKM=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 04:36:43 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 04:36:43 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: Recall: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to
 include hibernation interrupt
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Index: AQHYzwYUCZBYgScanki4qXReEc8C8g==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Fri, 23 Sep 2022 04:36:43 +0000
Message-ID: <MN2PR12MB4333E69C6D63367FC24B1B1E88519@MN2PR12MB4333.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|DS0PR12MB6654:EE_
x-ms-office365-filtering-correlation-id: 1ead2ac3-f1bb-4bb0-5026-08da9d1d374e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcoA0AnWcgeVxXL+DBLSDaSXZdwCdm6AO5Z7Nbo1JxQ8MoPp2eCdKaJWkQ71ImPr1UJqhBQSBJ069m/KuuFupDlZsLSrwxa6wusNh3yQw5SUIhT0tx+HMz+2jcHXlKif55rjIhQioITiTjxYQjqJ9rrPxmx55gz1JQGpYnUtKAZFSPt2qZL7OPPby6+s36P9CXxduP3Az1Z03sYgdqM7TtUWbur+HBCWIT4wPjofzziT5rzt3vPo3ZrQ9Ai+wGtuhbwbF6cfbl5tCFs/rZe0YZ2AE7znYF5mMgGHKuWQhQdcaATSkNpqKSh+/Q7278OjdWO119RR3jyY5P3upOGLTl+w73LVr3AHwLuSeLkKJnkHw+3vMEBppIURyPe5dRWAhYEZ7iuaVKaKjCObeLpFyyWhHfCUnOFSV0Cq8ZExPBRqVTbyg16q9gplClWoG61yobQ+6oGMzT2wRjKoVVBO8xueLSHzwZS8sJ2kzOHcNC+bRAWh8iao8wte5j/KFTY8C94iISpG8ecu1E20VYPO3jCoMLcirABA8ZY8v0bwh/p/PqPQVObc1Jbkj2kYe3g1o+GQjThhNgkZ2TeXKifkXi6t8ewnq6L9WDxkqUo23BTwkFDpiy4xYJ/802uVEEtSeiz7g+h1rQQ+eLmyWcj7pysb+O5EBnOGgSIhtgRZ8JJDTrm9yhEpjS6GUIJuENVOVrqIEH2j90QLVYcX+1MtQ9FMT8AaHsSOkQ9zWAC6P7pMn+0i+QvwIc35voSQZ82RTyhiOkmz2ULrQC/uxwXwWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(451199015)(83380400001)(71200400001)(38100700002)(7696005)(6506007)(122000001)(5660300002)(316002)(186003)(54906003)(110136005)(76116006)(2906002)(66946007)(66556008)(66476007)(9686003)(38070700005)(33656002)(41300700001)(558084003)(107886003)(52536014)(8676002)(4326008)(64756008)(8936002)(66446008)(478600001)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5o7LHl13RXXxRtEp058xSVrzvubVl7mjCt+6RxULNKec9vqU/z6khHDzZPCc?=
 =?us-ascii?Q?O+GCiq4rCMRodOzhpdfINMejpIrfiRxTR1J18BCm4+HsorD30etYLt7PZkUX?=
 =?us-ascii?Q?6Tt5r5mBXFBPGU6h4UcEy6C31wAZgGKRdpbsNi3x+cCZkkqP/9odR5SfvE1p?=
 =?us-ascii?Q?RKQjxP2Q3VIkjb1gY7qYg2AIzgF3R3hjqSUM/GZqyasdHo0X/I+g2AF/h2xI?=
 =?us-ascii?Q?aPyLfcIoqIydteNqzcynzhezb29z00zBgMj8HpySasAIkohYKeVMV/w6vV4L?=
 =?us-ascii?Q?hlphgnuxrnls6eKCyHDYC3HaUsk4SpnzrVFNd3cRpis07lBtB63HtUBqm/wC?=
 =?us-ascii?Q?hrSpFX7D4OspoYEm78Q+QTzR6lezo0lrw3ivy79S7iM7inR+NhqbIlzWEfSQ?=
 =?us-ascii?Q?tFSdSteU60kokGDNN4SvkEllHbS8QpVLtnGV2SlNMBd+JZPJe+KdrTycp1no?=
 =?us-ascii?Q?szond8OlZZy6iQPAJKHuNqBAO2K7CR8B27HZ74v7bwaKlBPMpJy1cGQytAHq?=
 =?us-ascii?Q?lXVhjuo8UKsGTVHOKlCtCrREKQLMzpmr6RDsQE3VTVGuXmtTFZL/NbX7hip1?=
 =?us-ascii?Q?/ZOCB6LVNY3FYu0x+DQyFMhkjnzgnkpWLab4CsYlTN6nO+zIPTWQLe+wIpzm?=
 =?us-ascii?Q?P+keGUkIzF/L+Sfm/xZo30/CEsiOfWKr2sEa8yl6s+nG+S59inyRrFlOKDi9?=
 =?us-ascii?Q?g/OC9nhMVc+IT5VsH5AwZb18X5XdMYgZHSHa9h6tTjt/SXOYPH+uUh3DM2V4?=
 =?us-ascii?Q?Uu8mqYygvLcQs0t7mxDdZalKrSeW9cn7KG2yAuVqwnLNFQhysoa6nCjafVjh?=
 =?us-ascii?Q?lMSpkHjEZxTy5HUsN42+ajARhgxjDGxGk6TUMuqQZrvrDzN0mE21nVBdtKav?=
 =?us-ascii?Q?WR3FZcZx6M/cHwq4utO3J1SpJFq9aoof1AZhnPDD07etReTu9CyyAlTnC1ZM?=
 =?us-ascii?Q?nA1tM+cKd7O7uNh41y+BmuL7YJHi3uXRaSVHuI2EKT+AcTt2qccI+VeKlX3F?=
 =?us-ascii?Q?64HwtMyZtdLB5xoHjYV2osCmrE7JhQsYHEXEAwnYpFcLpntG15w7XM4UdVUA?=
 =?us-ascii?Q?qgbmfonzAoG6ZfHjxihCMIx7mzrtuSzaiCbBFdvQXckBB9LtQWBy2SV7CN1h?=
 =?us-ascii?Q?tf7zAchrO+hAlXi1WZIFwiH8t4AHY6iKdY0CKNigJBKkIhR/CRy8AUfahOG9?=
 =?us-ascii?Q?HSWzLiTaqUe9pihOsmwjMyEd6GxwlGsmJuhv6IYgXRFdAUUVRoQaMWKNvtoT?=
 =?us-ascii?Q?VSkKiMCy4ls+/MEDAOKBdJ2PhQtfqta80hq2npYoDgKhwP6KTl1F0PW/NhjP?=
 =?us-ascii?Q?4ek/u8kK8cRoBqgYZZ8NlU1eWwp7yOVyGGUxmRSXUH8aTiHJVqnXNei5+/bL?=
 =?us-ascii?Q?pozHDve6+8oCB6VuRefNsF97Q0O4hT0PbeJu1XPLZXTSTeHXh3n//qr7OxKO?=
 =?us-ascii?Q?Hk0HyDEhfd5RvZOQVXl3yQFAhZp6Vn+q7TKmh6Vhh6EzmrAbCUKw1yP8Uc/F?=
 =?us-ascii?Q?xRus9Y6JWxFka3J+fYe+yhZCRCypMW38A4Tzo0fRbUsq7Ca91N8WhrED6xNa?=
 =?us-ascii?Q?eeJxITHZguM5yWvjbXstiBKcSTCPl6zn+niWzplQckFcUs/wG936ZHYZ7wXT?=
 =?us-ascii?Q?EbiIYiohnR4et03pa7p4Wzk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ead2ac3-f1bb-4bb0-5026-08da9d1d374e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 04:36:43.3526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obBG4MlSSGKF98mOZ191bdDdIfLC3GvrWqpNiX0T78P5Ix65hyBvXS/TxZIPDaRS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mehta, Piyush would like to recall the message, "[PATCH] dt-bindings: usb: =
dwc3: Add interrupt-names to include hibernation interrupt".=

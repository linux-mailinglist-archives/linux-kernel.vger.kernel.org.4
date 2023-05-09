Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130276FC26A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbjEIJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 05:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjEIJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 05:10:04 -0400
X-Greylist: delayed 2310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 02:10:01 PDT
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C1CDC53;
        Tue,  9 May 2023 02:10:00 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348LlX5w022619;
        Tue, 9 May 2023 07:44:57 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2171.outbound.protection.outlook.com [104.47.7.171])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3qf78mrgdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 07:44:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQMEu4iNpQL554UFAALVqn2gfI9EAiMqXzgjc0lLcO07rwuG0KGRgGtcZ6qCVMz2D3oHNBX116uEN0InQjjHxy/NYno7UUxWRO+eIRUN40IYh7nVqgpqtIp5KvfTnEvoxG0aPprEAV2FRZzZe3KZ2bZcEBsZcsQ0OeVeKHGqYV58RD+qpoRowZoZq7jSXv6TX1qwfZzXiKirDrR3vmQb5s7eka7jAuJ8A0IvYQfBKSq1rCoY07s2O/DtaZAg+NpPKN2zY4o09Vngam5+2IbaXicEx4qAgL/1XpkuJrPaBPp7qTiYTbpbXmBf+HfJwxNuTEREHx07rByP++4g8l+KoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN6NeA/IGhZ2wTqt23C5og+6vkNKsaC7V+NpHB2OcFA=;
 b=YeDQF088tvG615WvZtx2m5gVKFnmtt3awlWNEz/xwk+0U6Cb2K0SMoazPHClPnZtV6mtkznSb74DmC2/vLXZaiSrU9EIsXoDY78j7fVe7MOqB7akron8r0UdlUpaEBIIXFhlyvM1CLTU35B8qwy3KxDcStR6CwBhCpgeCjfV/bmwHfuwYypWLn1HUWF0+FoExu+LDWILPIX7ltlG32Xdbo37U/olWUsZTVS33dT/ScdsP3j3WmrPGkSsJ8uge3w9zqVzSJBO1Fm0F8pGT9ygAjmoO+g7cjaWH1XDzRx7oSSZJBBK0t2ykU/KrTDrjN8/7v8KN2qv8nSYjG3fmrnttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN6NeA/IGhZ2wTqt23C5og+6vkNKsaC7V+NpHB2OcFA=;
 b=UjnFp4d7imkrUiPVk5yYje9c3cURBX/vTQcWjRIerBXmvsYRPnsEXR1bS9RMF/NINrWRPx1KxH0KcDs2cHtCLyxVdM/vmE+uwDDaYRZijAZqtEiku2sTTKrJAthzyav7Y8KsaMb68NCOfGmCsyKictnwaowpfDenn+44zRjLt3kqORYSWQQ864C0xfA13HUGK8PqOCsMBMBjcwElKgLWVrXKrCSyGZyM6aRUj57bm+xsplYdGJY9RhqU67R1wwVBcX3WsucEbnj7gJNfUwGNIKqj/LwcFQ/yGzoPdKwtYD2ykbDOoqghoeoMiW2o3G23NAnFVl8DK2R5mIE/koZIOA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2856.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:4c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 07:44:50 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a30a:5ac8:b5a8:68dc%6]) with mapi id 15.20.6363.033; Tue, 9 May 2023
 07:44:50 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Hermes Zhang <chenhuiz@axis.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Add icm20600
 bindings to mpu6050
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Add icm20600
 bindings to mpu6050
Thread-Index: AQHZfxVmHEyey2NpV0KY14ve6Q3xWK9RlaL4
Date:   Tue, 9 May 2023 07:44:50 +0000
Message-ID: <FR3P281MB17579F786C827BC82100D291CE769@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230505054853.2155326-1-chenhuiz@axis.com>
 <20230505054853.2155326-2-chenhuiz@axis.com>
In-Reply-To: <20230505054853.2155326-2-chenhuiz@axis.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2856:EE_
x-ms-office365-filtering-correlation-id: 10d8b127-f698-4421-f178-08db50614529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLYmmt0IVMkn8H6Nxc48sgu9IVU66S6SEcUKnEDXNp6reXjGmLDPM2Ff4Gm2LTW89qNX/fTep5H3u1Y8MR1TF6vD2ee3VH6cQ28mmZCn6SHYk066YHb5fH6p5GWrdEGhnm0WWCXHEcQMPXEZf1hKjPU+U8X1s12fN/z2hQEO8JQFJ5urT7TlcsnaXYkOxtPzT4kFtxTyhx6MfpAgvFL7TBv8dXIKclCp6WDPn5x1DD+SILR5Y5lJSgXWo8wpbV0fY1bEtm7lTr0HYwWRRXDwk0qsnuUKOB813PHl/DC1lQLsQQNTLJjmDjwQNuAaRCLW0w6GxHuaiiQdlWJ+tvuLI/hRPch7MFk7+swiTwbxTjtM7W1Fp9J7iLwAgCBVTDSNBg8bybtsk80Qrc7FSxLSuNenANqGlHYE1fUOK2QdLqfZ88516dZPuK3SMe8mQsyF64bNS/bpkreXmk7xWUOON6ZWpUZ7syvS+egEn8oR6adbDI2gKO+zKbHxLfgRmKOOA0lsBqsATB9QmLEkuti+H6MQhBT/58Qmt7KbLWpVJMiWc3sSmSepngG4cz48YcgiFqwWYBwPQ8yo5J3tKY0vE4zv3UVfm3vBYBPY05YeXDKaFgEtbBwUA9lFJTWCMQnf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199021)(86362001)(33656002)(316002)(110136005)(54906003)(91956017)(66476007)(66946007)(64756008)(4326008)(76116006)(66446008)(71200400001)(7696005)(66556008)(478600001)(55016003)(8676002)(8936002)(52536014)(5660300002)(2906002)(41300700001)(7416002)(38100700002)(38070700005)(122000001)(186003)(9686003)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A6cFlL0lJf+ZD7SwO7V108AnkStNOSqN7htSxnd4THJ+bcMlHGPUdTm6f0?=
 =?iso-8859-1?Q?4M3EXPopCif5fwcwu6k6YMUaVfGJm8VDcGmFMHdm6G6vAIx/FeXlpdpuKO?=
 =?iso-8859-1?Q?q2LkPjHqwPDLNhIuuNHcdglE3dWyDbM0YU/FNZeBCnRxOfhUij4A51OibY?=
 =?iso-8859-1?Q?9nF1RU8Eb4IHkv4lMFrw83D3B1Bc/ecmJC5FfWOvPl05aKkQ771ZLfIGh7?=
 =?iso-8859-1?Q?spSKJaUm0ijR8N/ej3dtEvPykDXoFsqO8C3NrxUMeV8vnGR/GEhyvUejZR?=
 =?iso-8859-1?Q?eX5GzML8IErQiVvBLkNE2T0N50UzUZngt8kshjGiCAqs0JLcBCGHidxsR2?=
 =?iso-8859-1?Q?e5pyi4AeLCKG52qkAkc+0+xuCY88HK9S+v8b2B9JeqlenNwoNI3CMN6IiX?=
 =?iso-8859-1?Q?1JTdhENARBxNTAcZ1hh9Xmgmb/Z7pNqY6ZLI6u/K29zRA9f6925TX8Dozo?=
 =?iso-8859-1?Q?fCxCxWUaf1FZhn4o4cexOyZKS1J6HESpoxN6ws2J+G5PptoaTd4nDIQfEU?=
 =?iso-8859-1?Q?3eFqwiXALqlYPq5Z/0jfpwnAv36aHrf5iJNW0tzDuEV+9yZuLcuAShVaoR?=
 =?iso-8859-1?Q?tNe/gpRfV0Zkoo/D75jwT5bmcDEk/81KVbp1Knt155K0NNgcFIxQnVx/SZ?=
 =?iso-8859-1?Q?bELcO05JspjLsxwvvp8JDWGLrFDVd4lHpwz/ihESUuX6Vj79m6+4lYGBgE?=
 =?iso-8859-1?Q?4wNcZU2LNIC4/8EHwkIB5eNwPjhkJCwyfaWHrhjNsZXgi6vlSDDVvptpYM?=
 =?iso-8859-1?Q?A6gg8pJY4SQQb0pJgr1CdlIW+aInbpoFRnnXgbbKmElg3vJw7V11LsRWAe?=
 =?iso-8859-1?Q?np/L7lbQDm6kw7xu2X2Wvg1kf6MhXL+1wFfegxMhhmn9V0guotjtnEhK/p?=
 =?iso-8859-1?Q?GXyQzESzbIP7zeRKub3U9O4ZZTd22feKWIRDrwI08GlOSnB5CTuMvBI32v?=
 =?iso-8859-1?Q?EvKxamG96v3GFJTPUg4O8/FfEg8Jgu+LaPm7w1KHofc20Sk9Rt7AFfMyB4?=
 =?iso-8859-1?Q?cehijpBDAOBMPrAN6GNANC6SPzxta0ZzcK9SsmJfFjG220FF3nbOWjuNrA?=
 =?iso-8859-1?Q?9xqjaiut3ozf/aQ+H6ixO0u05jubFyYC0gFySJSBLHE6YKtBvS4/JJ4Sfu?=
 =?iso-8859-1?Q?SNclT3gIunprGpEeG5/zxL4WUMBhWY2V6DHamgtalfWJm9WehJUhFjOul+?=
 =?iso-8859-1?Q?aTxry2cK/kR+6DwIhMtODP3DSJUccov3no7n1frGfF0296EMzHGZVfKmJ/?=
 =?iso-8859-1?Q?D8xmlevpiTxW/HaHek9dirQiKirb7Mxf9zNL49CoSo0B1kStm+r6TmLESO?=
 =?iso-8859-1?Q?zGtXTmIomwqLJzmbImwOIXY7JO7S/g6LY9OtgbkmvtOOzMzqm3Fc1Q07mO?=
 =?iso-8859-1?Q?la5jOkmWE/Hjo0VOV7tlTRCyQRq3z0UggVlw1jjd9kyqVcsUMDqxV3Ywi7?=
 =?iso-8859-1?Q?uZwiLIVa3wYsoL5901jnDY2gS4zjZOHITrKGfrA/J1aYRfzV6Cu93R8L1T?=
 =?iso-8859-1?Q?lX8sjNct/j+s/9E0VDiQEyhxVhE2TFkeDOrK33oOUk31oZbQGdNbuWSfzH?=
 =?iso-8859-1?Q?bFV0KlWPXa9eC2CUxpVbNNzd9bwQcH1SEBBNFCnRF6FKY55SXWUt22QgzV?=
 =?iso-8859-1?Q?VMKSTndVDWsSu3uOBNwFdi9FcHV/vsxFKpErxSKQcMSXCCPL3lE/XzI7zX?=
 =?iso-8859-1?Q?Tdv/8TW0BzsCD6HDTv2QmYOwoB7Sn0glRUFmSgSyxn7FHZLSEBNUHJURm9?=
 =?iso-8859-1?Q?bn/Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d8b127-f698-4421-f178-08db50614529
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 07:44:50.5346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pq8ebWkR0U5WUvm4SQjbIVRBvp4uhZGUGT8M5UTFZseMYYjLm0Ksn6+yyBirKR1dCrdMdvbbJYe8MGa3bVsgdcSLcce86bXX6rW5TgC9MGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_04,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
looks good for me, thanks for the patch.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=0A=
=0A=
=0A=
From: Hermes Zhang <chenhuiz@axis.com>=0A=
Sent: Friday, May 5, 2023 07:48=0A=
To: jic23@kernel.org <jic23@kernel.org>; krzysztof.kozlowski+dt@linaro.org =
<krzysztof.kozlowski+dt@linaro.org>; robh+dt@kernel.org <robh+dt@kernel.org=
>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>; kernel@axis.com <kernel@axis.c=
om>; Hermes Zhang <chenhuiz@axis.com>; Krzysztof Kozlowski <krzysztof.kozlo=
wski@linaro.org>; Lars-Peter Clausen <lars@metafoo.de>; devicetree@vger.ker=
nel.org <devicetree@vger.kernel.org>=0A=
Subject: [PATCH v3 1/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindin=
gs to mpu6050 =0A=
=A0=0A=
[CAUTION] This is an EXTERNAL email. Do not click links or open attachments=
 unless you recognize the sender and know the content is safe.=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
ICM-20600 is almost same as ICM-20602 which already support in mpu6050=0A=
driver. Specify "invensense,icm20602" as a fallback compatible=0A=
=0A=
Signed-off-by: Hermes Zhang <chenhuiz@axis.com>=0A=
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>=0A=
---=0A=
=0A=
Notes:=0A=
=A0=A0=A0 v2: require specifying "invensense,icm20602" as a fallback compat=
ible=0A=
=A0=A0=A0=A0=A0=A0=A0 in the binding, as suggested=0A=
=A0=A0=A0 v3: reorder "invensense,icm20602" entry before icm20608 and add=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Reviewed-by tag from Krzysztof=0A=
=0A=
=A0.../devicetree/bindings/iio/imu/invensense,mpu6050.yaml=A0=A0=A0=A0=A0=
=A0=A0 | 3 +++=0A=
=A01 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.y=
aml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
index ec64d7877fe5..1db6952ddca5 100644=0A=
--- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml=0A=
@@ -30,6 +30,9 @@ properties:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - invensense,mpu9150=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - invensense,mpu9250=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - invensense,mpu9255=0A=
+=A0=A0=A0=A0=A0 - items:=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: invensense,icm20600=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: invensense,icm20602=0A=
=A0=A0=A0=A0=A0=A0 - items:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: invensense,icm20608d=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - const: invensense,icm20608=0A=
-- =0A=
2.30.2=0A=

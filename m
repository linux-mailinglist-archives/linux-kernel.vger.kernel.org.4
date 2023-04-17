Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932CD6E406B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDQHNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDQHNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:13:15 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88515421B;
        Mon, 17 Apr 2023 00:13:02 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H6XZKm012820;
        Mon, 17 Apr 2023 00:12:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=thhBMcc0EBTGcc06ruQeReJXKJgebBi6eSbZyrZQllI=;
 b=XU1JeYCMVmiDDcdsl05+B+HqJeyw/8PtP1ixZGFf723Xbqh0G1qLuk59uHO65INfQVch
 i88gGI6Rs9Lq5M5ImxkB1HSzDkYyRjE7U/SSe8MInbxFaFSDvq8Z6I0Db+0pIjyfVg4/
 JFoku9MWCDPorH7ppS+HrKZWQDVaeNdO2KzEPzj8505bs7z02ZD1Gr8Ck92mltS80v4E
 qou+kR90QrwkPd8fEq0CbsetOv/ZiRVFbM17N6W8cF2QvKmqTTJd2VXbtPVGLw/EUPfO
 xjFggxLVMo5Zxj+8X/1jF/beqq2bglyCJ2uffOQGaB+9G2T1FPNuvFRIpgp3lQXoLxBT /w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pyq76j5wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 00:12:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbpRhFVPue34lyHVErZQJJdZe0DJeSuXcCcuUW9yQSkwgUgeaV1QNFmQzbugjb2Oj818sZkkdosJyEl640e0rhIq3MU3IV6Cn9RkS2UUxvgrD35YHak00GxxtuaP76jna0LmNmYzVN5OntU9eDxSiT3PhT6oiUAjwQb9n0m85YVaEhPeZuOgK9ZXEqORtLvI/hq4MHVaqHZRThWPLz+EHpbsMkPddMeuu4nwByHcvuzogZV/U+Axz9oN2NCdkJ+WoiYVdc86UwpmIWJ+rC5sXMlh7acflK1v1N32qmseYy1gf26CNtNKa9jZTviOwt6ade5UeknteavqMUHvYtNmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thhBMcc0EBTGcc06ruQeReJXKJgebBi6eSbZyrZQllI=;
 b=I/Btq4/WM8mdFGpveAjThQQD2bNRPA1eFv5mOpKCwrNqAqyoPwzrJ0YC0fPQ3IZQNXSd/dOL54ciWV2T81B162jONO4OibAtJzgIw6TtGXJzMH+XL0G7DZKq38PcdFpfzyFmwKlJJ4jDhg/eqdmtMNEMRvF6JcHqz/ZbunRwsUE29eAPO9PqFCC2qBtP81fGqW2OpUfGkFOPzCLvHC7wKB/BIBcN0iNOch8fsTJAV+6jEGC8pTZG+iQHnoVjT7egK6BF9YtKZZnp08YmRsuDLNtwUsrWQMThSKd87K0nLYFeqXzIumY5JYTsGrx2W/Yf3UwdY9dEZj1P0YPhanX5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5192.namprd11.prod.outlook.com (2603:10b6:510:3b::9)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 07:12:16 +0000
Received: from PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::aa1a:68b6:ac4d:e4d2]) by PH0PR11MB5192.namprd11.prod.outlook.com
 ([fe80::aa1a:68b6:ac4d:e4d2%8]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 07:12:16 +0000
From:   "Song, Xiongwei" <Xiongwei.Song@windriver.com>
To:     kernel test robot <lkp@intel.com>,
        "sxwjean@me.com" <sxwjean@me.com>, "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 2/5] slub: Put objects_show() into CONFIG_SLUB_DEBUG
 enabled block
Thread-Topic: [PATCH 2/5] slub: Put objects_show() into CONFIG_SLUB_DEBUG
 enabled block
Thread-Index: AQHZbhU8aeWiQXUXRk+bSdhl9wcU9K8phagAgAWVaRA=
Date:   Mon, 17 Apr 2023 07:12:16 +0000
Message-ID: <PH0PR11MB5192D219F650B74F6339206BEC9C9@PH0PR11MB5192.namprd11.prod.outlook.com>
References: <20230413143452.211250-3-sxwjean@me.com>
 <202304140110.lzjsYh25-lkp@intel.com>
In-Reply-To: <202304140110.lzjsYh25-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5192:EE_|DS0PR11MB8133:EE_
x-ms-office365-filtering-correlation-id: 851f9fe4-1d0f-4f68-db1e-08db3f13131c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUNT3zcdFUX6l0KJXuVis8VwMTes/mPfJoB3P8uUvjsjkFN1D8O+xwP3RtfBH24p8afYasUOMKoPFKJ7OfSn6hNOBlpjHYfNUpzBVoycHXDTI/zr11FVdCY6ta11ixXKWCYhAHJK2LNBi2sR1RjuNLOFG9ERXB5lkviCphb2H7WWF7sMeMUC2WGwjIZhq+V6VMVRiiIGaT2SRyB/Goy8r4vDX90qQ4f9NCAYIJnofOTLA569H13bCYCKfRU9rbQDgATF4QTIXsh7WQziIXRMgFkOd7KTkfBBgzK1qn9rZmZtKgAnNVrYf22ICQU5K04NpqQ/8SonqQqIjbc61a1DVDtMPWL3qofvPsYcct2Yw8smtEcu3hNMMkrFISGyJfF5SMFsgbraE6ef9eqHKKH02DR2gUKf5aTH5Onk0OLBa70AuONsTnb9P6MZXKNZzTrRZGLVFtTHxgA5OG3V2rd5FGmxGBit3ARueQsfXqecd1SWyx4lXqd4XZQTeTACg8SJjwczckMoHSevcDyvY4+REAqnTXZwiZJFPryue066tRvDqV2/ltKTW5Hs2rK/Sn9jgBI+WZbgrJsJZoI5HRL4uyhjNHhWjy8u7CzPV84oyYvEe7NBdN7o8hYPkf4XPEWxX4S3SWbQeD4Wp/31p7QWuKdKf4GEnZ2q98oqGqBmaGE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5192.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39850400004)(396003)(136003)(346002)(376002)(451199021)(110136005)(9686003)(53546011)(26005)(6506007)(54906003)(55016003)(186003)(83380400001)(71200400001)(7696005)(966005)(5660300002)(33656002)(478600001)(41300700001)(38100700002)(8676002)(921005)(316002)(52536014)(8936002)(38070700005)(86362001)(122000001)(4326008)(66446008)(66946007)(64756008)(66476007)(66556008)(2906002)(76116006)(4001150100001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MDQrZmt5RzBjbXUzQ25ObHpETVBEMVdnNk1tVTBvQW9FTnUyUlFaQ2Y5?=
 =?iso-2022-jp?B?TitqTXJCOGNVcGF2aWhCZTJZRm1RSXhaWmJMVEZwdmxseWExbDg4RlF5?=
 =?iso-2022-jp?B?dk5SZzBlV3NocThZRFpqbmU1Qm51L1RzQ2UrejkxcjZ6NUNmY3pWdG1n?=
 =?iso-2022-jp?B?Z0NlRWVDVjg4UkU5dDVWS0lRK2tYNmI3NlJaajRwOThtbEZRNjdZSkYy?=
 =?iso-2022-jp?B?bUlzcXRXSEFiSmtWVGNhRzgwcDVjVUg4SFQ2OXJWaSt2TUFDdDEzWXFF?=
 =?iso-2022-jp?B?WTNWanA4dnRiWmJKQjhqWHI2NnZUc2NIZ3JYTFJuN2dhc0pRV0NnQmZ1?=
 =?iso-2022-jp?B?eGhIUEFaSlBMUkNTQytFcWlYalh4eldYME9FL2s2UDgrME5HUnE4cmhS?=
 =?iso-2022-jp?B?cFUwV2NVR0lldVVXVVdQUHJkMC9Gakk0bnRibEpXYnErdmFiRUhsaGFq?=
 =?iso-2022-jp?B?RURWOStSKzRCUnpJYmxUUmU5K0ZhYXRDREFpLytPNEhBQVdjZGlFR01h?=
 =?iso-2022-jp?B?MlkzU09PWWxGdXk3YmRzNkkxSXd0SHNyUzV6REY5VSt5ZTJ6TmZURDlU?=
 =?iso-2022-jp?B?V3lxbCtIenBTM2NRSEIrbmptcUs0dTI3OVJ3anAwWEVvMThnekwwc1Fi?=
 =?iso-2022-jp?B?RlFnY0NSQzlxQkZoOEx3NHR1NXU2cU96SGo0ZnZYTTJoRC8vamFjTDlU?=
 =?iso-2022-jp?B?SzNOSEdDNm9jZkl4QzhROUtKU3Bmaml3T2J3WGltcEdTNW53Tm1SalRE?=
 =?iso-2022-jp?B?cENFc2hFRlpCL2ljN3oyY1BxK2o3b3JCcnZ4b21leG9remREai9ZM1NW?=
 =?iso-2022-jp?B?ekF6UTFQY3VMZHhPM0FZbXE3YldUaS9hMnQ3d1R3akNVODhYNG41aU5P?=
 =?iso-2022-jp?B?dEFia2JBYXYza3l6cnIyamJiak5RTHJTRWJ0ZWZmTW95Wk9pOFh2N2x6?=
 =?iso-2022-jp?B?SEhWUVArb1l4eEdERVdaTThjczg5Rm9TQjZFUnZWQkdWTDdtUmVSZ3RX?=
 =?iso-2022-jp?B?UWJuY1J1L2VpQ3VzRC9GSUgyV0J2aDJ6bnRoaWE0UThZQ0RZaWt2Tzdk?=
 =?iso-2022-jp?B?dnFmK1ZGbzMwdEpsdmJFbW43Njl0RDRBMlV1empCd0FhUGxGYlg4cDBF?=
 =?iso-2022-jp?B?WDBTVDAyRFE2TWxZYkNVUHRqUWFNYmRxYlA5OVllbnRxckkzaGxIY25m?=
 =?iso-2022-jp?B?dW1PSEhidWJvT2FzN3pBa0ZFRkI2eVptb1RLeVFmSC83ZHg3N3NVNjV3?=
 =?iso-2022-jp?B?V290ekc1R216d0JybU5pbzNZWWJkaXA1YWx5aHUxeHB5Sm5XaG1hVlU1?=
 =?iso-2022-jp?B?Ky9HbjJsNjlMeURITFFMbGFHRmpkcGhQOFlKTmZVMmVseWhSaTViaHlw?=
 =?iso-2022-jp?B?QzVjYW1PQmVSOTN4OEhESmdhVnhVOTZmRi8vWkRrMEJPd3hYYS9yWDhJ?=
 =?iso-2022-jp?B?eW5YSmk5QXVDSzJucEJ4cTNGVHJ1ZTg0aU90ZmQwV0hiaEU5d0NsaXFN?=
 =?iso-2022-jp?B?c1ZEZkxLODJKTllXaGZSdldXVWZscmZJNFJmM1g0Q25nWFFpVThhemMz?=
 =?iso-2022-jp?B?SXJZSmZhK1cwaVZ6VTVHMm05QmRXT2FiS1AxcDZlV3kvODEvejhnMHlZ?=
 =?iso-2022-jp?B?US9jZ1oxbnhVdkJ5S2Z1MGgzYzJ1bGJLOGJYb2pBZFB5VGFSTUwyV211?=
 =?iso-2022-jp?B?dHJqWlQ1TWoxM0JOTmR6TE5FQTFpNlhlTFQrMmJaaUlKMmFjQWVNakRp?=
 =?iso-2022-jp?B?QTV6VG9WcDNpWU1qcnI3STFIOStpSXFvTWFTd013SGswWTZKbGpkS1RQ?=
 =?iso-2022-jp?B?K2ZDZjRTbk96VzlmaVUwa09aL250cUlVeG1sNWc5Q3RHNkdLMWZ4VWZK?=
 =?iso-2022-jp?B?S1l0YlJRb1gwZEZlL2U2eDF1Vlp0SlNmWDJ3ZWFwbkdCVTcrZENYOEg2?=
 =?iso-2022-jp?B?c3dmd3RHT2YrMDdOMHpmdUhLSFF2WjFadUZuZDkvZys3QURnTExxZ0tp?=
 =?iso-2022-jp?B?RGpxc1JneXRrZlEzUDByUm5OdlVqSXBmWVErdzNvN05OaU1SM1gzVlZk?=
 =?iso-2022-jp?B?bzBqZ3JPREN4S1VNYmRpMkNPSVlXZ2FWTW05MEtYVXFwWFBMSXZPcSty?=
 =?iso-2022-jp?B?dHJ5TWF6ZFhNN2R1N3EyQWdZa2kxK2czeGJZcnd1bmZhSXdBQUZ4dS9W?=
 =?iso-2022-jp?B?WjYvZ3NvRGZHNnhZcUNOS1JFblpSRWJzZFhYa0hUdTcyR3QrK1dpY0Zx?=
 =?iso-2022-jp?B?OGtKU2VJa2VXRWxmVUVTbW1DNitibG1oQ2doWFptaWF4aE5BdmxoMUpH?=
 =?iso-2022-jp?B?Z0FIZA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851f9fe4-1d0f-4f68-db1e-08db3f13131c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 07:12:16.0537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zux/bwDJSfbJ9HSeR5J5QniZWLwrhHjkEcAr4V9Kat02HDgSnWTsjgo4dhUgxvSbTtX+Y9Ttf33QwaRSR25fsB4XukDGZOnP29IdwxV8LSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-Proofpoint-ORIG-GUID: jZDy5hdQH4o17pDmeOAH_eBZmLSvVXSv
X-Proofpoint-GUID: jZDy5hdQH4o17pDmeOAH_eBZmLSvVXSv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170065
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, the diff should be:

diff --git a/mm/slub.c b/mm/slub.c
index 28ca576d988d..0d99440727a5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5613,12 +5613,6 @@ static ssize_t cpu_slabs_show(struct kmem_cache *s, =
char *buf)
 }
 SLAB_ATTR_RO(cpu_slabs);

-static ssize_t objects_show(struct kmem_cache *s, char *buf)
-{
-       return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
-}
-SLAB_ATTR_RO(objects);
-
 static ssize_t objects_partial_show(struct kmem_cache *s, char *buf)
 {
        return show_slab_objects(s, buf, SO_PARTIAL|SO_OBJECTS);
@@ -5713,6 +5707,12 @@ static ssize_t total_objects_show(struct kmem_cache =
*s, char *buf)
 }
 SLAB_ATTR_RO(total_objects);

+static ssize_t objects_show(struct kmem_cache *s, char *buf)
+{
+       return show_slab_objects(s, buf, SO_ALL|SO_OBJECTS);
+}
+SLAB_ATTR_RO(objects);
+
 static ssize_t sanity_checks_show(struct kmem_cache *s, char *buf)
 {
        return sysfs_emit(buf, "%d\n", !!(s->flags & SLAB_CONSISTENCY_CHECK=
S));
@@ -5944,7 +5944,6 @@ static struct attribute *slab_attrs[] =3D {
        &order_attr.attr,
        &min_partial_attr.attr,
        &cpu_partial_attr.attr,
-       &objects_attr.attr,
        &objects_partial_attr.attr,
        &partial_attr.attr,
        &cpu_slabs_attr.attr,
@@ -5958,6 +5957,7 @@ static struct attribute *slab_attrs[] =3D {
        &slabs_cpu_partial_attr.attr,
 #ifdef CONFIG_SLUB_DEBUG
        &total_objects_attr.attr,
+       &objects_attr.attr,
        &slabs_attr.attr,
        &sanity_checks_attr.attr,
        &trace_attr.attr,

Regards,
Xiongwei

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: 2023=1B$BG/=1B(B4=1B$B7n=1B(B14=1B$BF|=1B(B 1:54
> To: sxwjean@me.com; cl@linux.com; penberg@kernel.org;
> rientjes@google.com; iamjoonsoo.kim@lge.com; akpm@linux-
> foundation.org; vbabka@suse.cz; roman.gushchin@linux.dev;
> 42.hyeyoo@gmail.com; keescook@chromium.org
> Cc: oe-kbuild-all@lists.linux.dev; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; linux-hardening@vger.kernel.org; Song, Xiongwei
> <Xiongwei.Song@windriver.com>
> Subject: Re: [PATCH 2/5] slub: Put objects_show() into
> CONFIG_SLUB_DEBUG enabled block
>=20
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender an=
d
> know the content is safe.
>=20
> Hi,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on vbabka-slab/for-next]
> [also build test ERROR on linus/master v6.3-rc6 next-20230412]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:    https://github.com/intel-lab-lkp/linux/commits/sxwjean-me-com/slu=
b-
> Correct-the-error-code-when-slab_kset-is-NULL/20230413-223743
> base:   git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git for=
-next
> patch link:    https://lore.kernel.org/r/20230413143452.211250-3-
> sxwjean%40me.com
> patch subject: [PATCH 2/5] slub: Put objects_show() into
> CONFIG_SLUB_DEBUG enabled block
> config: i386-randconfig-a012-20230410 (https://download.01.org/0day-
> ci/archive/20230414/202304140110.lzjsYh25-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=3D1 build):
>         # https://github.com/intel-lab-
> lkp/linux/commit/356157a450e3905cdc07fd0e77c4ac42974706c7
>         git remote add linux-review https://github.com/intel-lab-lkp/linu=
x
>         git fetch --no-tags linux-review sxwjean-me-com/slub-Correct-the-=
error-
> code-when-slab_kset-is-NULL/20230413-223743
>         git checkout 356157a450e3905cdc07fd0e77c4ac42974706c7
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 olddefconfig
>         make W=3D1 O=3Dbuild_dir ARCH=3Di386 SHELL=3D/bin/bash
>=20
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202304140110.lzjsYh25-
> lkp@intel.com/
>=20
> All errors (new ones prefixed by >>):
>=20
> >> mm/slub.c:5947:10: error: 'objects_attr' undeclared here (not in a
> function); did you mean 'object_size_attr'?
>     5947 |         &objects_attr.attr,
>          |          ^~~~~~~~~~~~
>          |          object_size_attr
>=20
>=20
> vim +5947 mm/slub.c
>=20
> b84e04f1baeebe6 Imran Khan        2022-08-15  5939
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5940  static struct attribu=
te
> *slab_attrs[] =3D {
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5941      &slab_size_attr.a=
ttr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5942
> &object_size_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5943
> &objs_per_slab_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5944      &order_attr.attr,
> 73d342b169db700 David Rientjes    2009-02-22  5945      &min_partial_attr=
.attr,
> 49e2258586b4236 Christoph Lameter 2011-08-09  5946
> &cpu_partial_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06 @5947      &objects_attr.att=
r,
> 205ab99dd103e3d Christoph Lameter 2008-04-14  5948
> &objects_partial_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5949      &partial_attr.att=
r,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5950      &cpu_slabs_attr.a=
ttr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5951      &ctor_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5952      &aliases_attr.att=
r,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5953      &align_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5954
> &hwcache_align_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5955
> &reclaim_account_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5956
> &destroy_by_rcu_attr.attr,
> a5a84755c590041 Christoph Lameter 2010-10-05  5957      &shrink_attr.attr=
,
> 49e2258586b4236 Christoph Lameter 2011-08-09  5958
> &slabs_cpu_partial_attr.attr,
> ab4d5ed5eeda4f5 Christoph Lameter 2010-10-05  5959  #ifdef
> CONFIG_SLUB_DEBUG
> a5a84755c590041 Christoph Lameter 2010-10-05  5960
> &total_objects_attr.attr,
> a5a84755c590041 Christoph Lameter 2010-10-05  5961      &slabs_attr.attr,
> a5a84755c590041 Christoph Lameter 2010-10-05  5962
> &sanity_checks_attr.attr,
> a5a84755c590041 Christoph Lameter 2010-10-05  5963      &trace_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5964      &red_zone_attr.at=
tr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5965      &poison_attr.attr=
,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5966      &store_user_attr.=
attr,
> 53e15af03be4fda Christoph Lameter 2007-05-06  5967      &validate_attr.at=
tr,
> ab4d5ed5eeda4f5 Christoph Lameter 2010-10-05  5968  #endif
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5969  #ifdef
> CONFIG_ZONE_DMA
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5970
> &cache_dma_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5971  #endif
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  5972  #ifdef CONFIG_NUMA
> 9824601ead957a2 Christoph Lameter 2008-01-07  5973
> &remote_node_defrag_ratio_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5974  #endif
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5975  #ifdef
> CONFIG_SLUB_STATS
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5976
> &alloc_fastpath_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5977
> &alloc_slowpath_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5978
> &free_fastpath_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5979
> &free_slowpath_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5980
> &free_frozen_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5981
> &free_add_partial_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5982
> &free_remove_partial_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5983
> &alloc_from_partial_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5984      &alloc_slab_attr.=
attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5985      &alloc_refill_att=
r.attr,
> e36a2652d7d1ad9 Christoph Lameter 2011-06-01  5986
> &alloc_node_mismatch_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5987      &free_slab_attr.a=
ttr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5988
> &cpuslab_flush_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5989
> &deactivate_full_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5990
> &deactivate_empty_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5991
> &deactivate_to_head_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5992
> &deactivate_to_tail_attr.attr,
> 8ff12cfc009a2a3 Christoph Lameter 2008-02-07  5993
> &deactivate_remote_frees_attr.attr,
> 03e404af26dc2ea Christoph Lameter 2011-06-01  5994
> &deactivate_bypass_attr.attr,
> 65c3376aaca96c6 Christoph Lameter 2008-04-14  5995
> &order_fallback_attr.attr,
> b789ef518b2a723 Christoph Lameter 2011-06-01  5996
> &cmpxchg_double_fail_attr.attr,
> b789ef518b2a723 Christoph Lameter 2011-06-01  5997
> &cmpxchg_double_cpu_fail_attr.attr,
> 49e2258586b4236 Christoph Lameter 2011-08-09  5998
> &cpu_partial_alloc_attr.attr,
> 49e2258586b4236 Christoph Lameter 2011-08-09  5999
> &cpu_partial_free_attr.attr,
> 8028dcea8abbbd5 Alex Shi          2012-02-03  6000
> &cpu_partial_node_attr.attr,
> 8028dcea8abbbd5 Alex Shi          2012-02-03  6001
> &cpu_partial_drain_attr.attr,
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  6002  #endif
> 4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6003  #ifdef
> CONFIG_FAILSLAB
> 4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6004      &failslab_attr.at=
tr,
> 4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6005  #endif
> 346907ceb9d11b9 Vlastimil Babka   2022-11-16  6006  #ifdef
> CONFIG_HARDENED_USERCOPY
> 8eb8284b4129061 David Windsor     2017-06-10  6007      &usersize_attr.at=
tr,
> 346907ceb9d11b9 Vlastimil Babka   2022-11-16  6008  #endif
> b84e04f1baeebe6 Imran Khan        2022-08-15  6009  #ifdef CONFIG_KFENCE
> b84e04f1baeebe6 Imran Khan        2022-08-15  6010      &skip_kfence_attr=
.attr,
> b84e04f1baeebe6 Imran Khan        2022-08-15  6011  #endif
> 4c13dd3b48fcb6f Dmitry Monakhov   2010-02-26  6012
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  6013      NULL
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  6014  };
> 81819f0fc8285a2 Christoph Lameter 2007-05-06  6015
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests

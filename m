Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF5714729
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 11:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjE2Jib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 05:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjE2Ji2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 05:38:28 -0400
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D23ADC;
        Mon, 29 May 2023 02:38:25 -0700 (PDT)
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34T52RA6001045;
        Mon, 29 May 2023 02:37:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=+Yif5jSnp5Z4myoG/x5Z/zbbd9rGhXhAwTxgTgG9GUI=;
 b=nO3BYG15gCiMRPUgXkcoePs0Dc/vBwvhUIvaHDRRYXKRVLtnOAThGiiHQo6MRl9Ye2/T
 jSh9HehGBgJL5pcPq8pyerHyH+iqoEUA9PNDBW/tMoI/95NJFOi+0BhzER8emtaTG40m
 QDw/fkgRE72J+tulz0TyI4IjZWmL5cl6kzBw/TCeUro0DKPlLLjyGfUMyRIUtc+E676X
 qi4DtdEJSUVJiYhJmvj2Kj+bA2BP8SOryhqbqtV/xtzs8Ju5GrHHSlkKxGvOVTnLkP9p
 iuSuQ6lXOPAp9cLFhznLOCbm9kY/OSDEfS0LLajyxmb2f5aA4peQanD2i4DNMwf640pd 2w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3qudeww70w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 May 2023 02:37:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwUmjJidlMjgYQlnu0ThKzbwLTKhO1LwrEMO8dUVrm5M0AvgEGseJoRjmkiHwITWgPNYOcW6c+Hq1/oMlTgo3sfjONYbZ+/h1CS2t2qknwj8fMjuEykq0LqbtM9g15nKLUlQ1AbPzOOnbeYDytV3hp5Y4k57+eM6/fynpoEfvhUnNszj6P5cl/Bxb3pcdRasVuyhOcGWTysMz2gOa7wXqQwmHn2dJngCqe+nLawswJqvEHtRiAEVufMqQ2iWKwhksqDdeRB3FnRmXrNsEjslims3P2+XcBhtokSsTb//NSRXpOM+02SMXYqtJRXwLBh1Vbif/hPvkYouNXg9+tBssw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yif5jSnp5Z4myoG/x5Z/zbbd9rGhXhAwTxgTgG9GUI=;
 b=YsddRrqXMK3U+wcTc/DF07GYD2uvHh+g8fePo9bkACblJMnFj8jB9lskkVD5K4K5xb8pWsvp0fC+ACiT7+YVHdk9pAZeF935HwpN8/boujTqp5vps5UmRND1hnwYtaR97km3EcxbkUzwyXNdoDN6In2YG445fVzgVnurk53W2XwEfA2S9YNwjjt+pRdQtgUXhihzMCD3vc98tRPvhz/J+pmQprj2WlJJEwQXR5oIvmlerPmjKO/lhv7Q42WoCN2blxsVeQhOsbhpsixwpvaikPDPVF2XTDNkoI3uJASZBOOo3yhC4jbeObZ3KlbgF2H8DdxZAb58ZbGMycedTzbupQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yif5jSnp5Z4myoG/x5Z/zbbd9rGhXhAwTxgTgG9GUI=;
 b=60VoPegf+kAfPmzBSZ8K+y9hxWy8TG3Cy7tBNy0p5SuMubkMVxNqfwq2PmIKq1gpS93lpVK9SxHrB6Z/PLSoKsDakqtJcwZp1BWgAbZTbYBlWZYXx9M8Cjm98nzB2kk0FlSW/3zjIDyNEgBwcj5GLLFSgGs1a8exFNEgiW1Ai9Y=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by MW4PR07MB9448.namprd07.prod.outlook.com (2603:10b6:303:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:37:49 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::98d7:262a:1d4c:8b47]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::98d7:262a:1d4c:8b47%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 09:37:48 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        "tony@atomide.com" <tony@atomide.com>
Subject: RE: [PATCH v3 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Thread-Topic: [PATCH v3 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Thread-Index: AQHZjsy49zIktJKfA02soIUqj6/kqq9rWw8AgAWoxqA=
Date:   Mon, 29 May 2023 09:37:48 +0000
Message-ID: <BYAPR07MB5381A583DCBEF51CDBE2792CDD4A9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20230525054916.243330-1-pawell@cadence.com>
 <20230525054916.243330-3-pawell@cadence.com>
 <99737c85-625f-9067-f72c-ddc6822866e2@wanadoo.fr>
In-Reply-To: <99737c85-625f-9067-f72c-ddc6822866e2@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzZhYzUxYzgtZmUwNC0xMWVkLWE4NjctNjBhNWUyNWI5NmEzXGFtZS10ZXN0XDc2YWM1MWNhLWZlMDQtMTFlZC1hODY3LTYwYTVlMjViOTZhM2JvZHkudHh0IiBzej0iODU4NSIgdD0iMTMzMjk4MjY2NjUyNzcyODcwIiBoPSJwTnJrb2F1NENyTG9iUFVDUzNxak9LYW9XdmM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR07MB5381:EE_|MW4PR07MB9448:EE_
x-ms-office365-filtering-correlation-id: 8403ef24-68a8-49f1-c19a-08db60285d37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NKATJWaT6AdL/QBjn9mgPoJgRlmjKyDmlAmvkDVNgWFBlbw3J7LfoN19N3LaS3hgqEZrFRCh88AMqTS2Fbdnp45Tu0M47VULTSqEzkHcodoncKePSQQpORWzpWQZVCLAK6+uuqLIsQ6EylV6WGjFOMh0Ulkxzip4olZDcNyHcqU+oU98L4DX1IK4zsgTvKnhzd65K8syTGzCHtWTiHQDPY4mt9v1fNNKhr7UCRTMUhfayHu00emV7gkABAaKAGVBnwyBibwVCFGq2UBf+ndX3YQQk3iEb/uRqoa7xAExbM5iTIMiVTjp4fkKS0+ii1e/kbvkd+uS7fOoR4lH1YIDi1otTyNWwNm+1rQRa+DAJwPmywk4JoeohFgCqMsOjvIOCh3KW0V4t3Z4AkeW3V5rDzTJWp8CtpmcjmxE7tNNp2iOD/nW6qr3SS+y02lTMTIL51h9xXJuAeNw9S56uGLdoewwAhoVf0o+kKvCb+NIVDn8+RjmVL5/3L+GoEq+1g3u5fK5RjDnXepRM84NWzc5bCcF3GumJN0qvyVSvfcYHEpkSSbeTe467yg1ydIe5UXUkoKyv3qjXddqkB+vWhx1e503S7usjSJ3XJH+pKJZv9r+M9Hgg9ePmkqvIykKfV2F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(36092001)(451199021)(122000001)(478600001)(38100700002)(86362001)(38070700005)(66446008)(66946007)(83380400001)(76116006)(66556008)(66476007)(64756008)(54906003)(6916009)(4326008)(71200400001)(2906002)(9686003)(7696005)(186003)(33656002)(26005)(316002)(6506007)(41300700001)(7416002)(52536014)(5660300002)(8936002)(8676002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEhoNS81WHJWYjl0NXZFOFFUY24rOFBNTTRiMG1tMGpVSXNCMGd3UWtxSEE3?=
 =?utf-8?B?M3lSOStJU002S081c0lMNTc1eUozYzFScUsyNjdTRDN0OFlIMDREdWNKL2Q5?=
 =?utf-8?B?Nkt1TURTb1htVTRNZEtXcTZXKzZUZXFsVXJlMnJkYVcyOUpUd0JkcVlxYndQ?=
 =?utf-8?B?UkVIdHhtdFlSQ09Qc1Q5MkI0MkpCOFZiMEUxcm5sU2U3TWRla3RuMVFITW5w?=
 =?utf-8?B?T05iam03RHgyYTRsNUtoU1lUanFoSEZDdXFLVGgva2tscVpxbnk1ZlZHbTVX?=
 =?utf-8?B?WU9UTkRnUk1aSDZoWDh2cVBHSXUwUEpudHhsKytHc2VaeUQwMVhBdmxRNVBQ?=
 =?utf-8?B?RXNTRzhrUmpvN2c2U2FSVGhZUklUc1dqa2dtbzhQNkJsYVo0SERHUDNtZjd2?=
 =?utf-8?B?MzdRZys4NjlBY3BtVHBncFZuWHZJNzB3RHg3RktpQ1Y1MXgramNxSEhhbi8r?=
 =?utf-8?B?akh5ZjhZQTZhWXJHNkVWWUdQRTMwblUybWtWakxKWWlFNEZtZHNUZHZVM3ZL?=
 =?utf-8?B?UkVHN0JZTWRLcmRXV25yQ2hIOFk2TGxUcXdISGhjRDRVS3dMUjZIUDA1NjlI?=
 =?utf-8?B?UEtNNGtMaWk3ZkFYNzdXYi9mUWlheEl5OXRQQ2tKdzFkRmVUcERqTnpFV3Rq?=
 =?utf-8?B?a2NkM2dxczF4UW5Nc3lmRFpKUksrN05wV3JSSHNhNXExRkk1N3A1N1FvVTBR?=
 =?utf-8?B?OGZKQ01wTEpQWHhWcEtTNWkyd2RxbXRPY1ZidWg0Z0VpWStNektpRnE2WWhK?=
 =?utf-8?B?elNqWlFweTYzbXZKRVJiOUxsWEVhRldMSFFnQ0E0V3hvbGJ2V3ZzZTEwNW9u?=
 =?utf-8?B?ZzNDUkJhM01TeFlabXVaN1hLK2hiVDNMVTVWYjVVMENDMjZuWUhiYnpWV1VC?=
 =?utf-8?B?b05rMDIxNmExalo2YmdocDd6YXRJaUkyc015ajNUZ3Q5MGRXVlNwb1M1ZDlq?=
 =?utf-8?B?OCtnYUlucVFVWmF2THJuKy9ud0s0Y2RURUJheTVLSXlWUFdYTkVIMDl4c0E2?=
 =?utf-8?B?NHYxQTNUTldXWVFGUmJodlJUY2FXQjZucmpFUlZEdnhHZXJFMHVmMitXQU5a?=
 =?utf-8?B?S0F5NEkwZWJjdmNLbEVXa0owMlMvclNGeFRrd2FrdEs2RW5aVWliVysrUnN4?=
 =?utf-8?B?SWxwNWVRWm9VejM2RmpmZHkrSlVReC84eDM2K3M0TytwdnZLeThrbko2cXYv?=
 =?utf-8?B?VTQzQThxVTBBNnd5UVFKOEE2QXVaRy9wTUpSYmdxbW1pR0VMME4zOWdONk9y?=
 =?utf-8?B?UXVoZzZIMkRpK0kvd3Zma3pwM0FUNWxRY09ueEYxTmRTOUs0RDd2a2pCUk1I?=
 =?utf-8?B?bzN6YTlQTGxTNGhQZ1JpQ0VUTEpTZXRjUmxUeUN4OVBxT3p0Nk84Y045cWZG?=
 =?utf-8?B?ejZLU25GbmFPYzZKUjBraE1nRGhxdlplVEZLSmMwdTZMNVJoU0wwNXl0QjJ5?=
 =?utf-8?B?bkVKU1RrMU5FOGVVWEFtZG9WeCtaUUIxVnBHQ1ZjcTNEOUNmR05aR2hOelNa?=
 =?utf-8?B?YzVzQy85K3FOdnhTdHYzQTliTWt2OHl1L09sYWtqNTN5V1o3dGNPMzVtN0lr?=
 =?utf-8?B?ZGdrNlB1cTVCMFpucE1KWGt1RHMzbkJyMEp3ZUEvK2M0TnRoZURLbUdtZ3JV?=
 =?utf-8?B?d1FzY3J3OHNqd3pHa3ZpMlNTa0k2R01wb3VUWTVXWDE3TEErWllnejEyanU2?=
 =?utf-8?B?OEJkcmFINXd2Q0JFQ0phdEcvL1czZldDTXUzOGw3MmhTeGtqcWFrRDd0ZTIz?=
 =?utf-8?B?QWFTS0pVbGhBMnV6S0w1cnF0c2NVaFExVEpxYnpEelJ5QUhLOXJrbnNwcU1G?=
 =?utf-8?B?elFOcXJFbFpRcEJ6NUU5TDR2T043aVordlN0ckY5MDlhU3NBbUhSOG9uTGMz?=
 =?utf-8?B?YkNZZkVudVhaNG90R0hwVXB0S2JKaVpKYUNsRGNJN1gwS2dzeXNYbzlKSFMw?=
 =?utf-8?B?UDRqQUEvanhNVTgxbGVpZGF0dVRYOFp0VWlMbkUvVm1CS2k3MnVSSjNjNVpM?=
 =?utf-8?B?dmtqaXRPNnJ2dTZ3K2tncXF4NzZaZittYkNrRUdBd2lHbGdwSGpHZWEyVnBp?=
 =?utf-8?B?cWdWL09mRG9mS0t6eE1KVlVsQncrakxIUzB1Rnd1UVdXWTM3QjRiNDhHQ1RG?=
 =?utf-8?Q?czukqdqV5zcmAj22uBdHxmJTQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8403ef24-68a8-49f1-c19a-08db60285d37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 09:37:48.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ywo1V11c00lkrouV+QGpuIQQOWZvo+wbKyKuG0+uEUORqqdHttnC1TuTJ/0sumREY8jPA1pQLFqfVgoynTFmm/X6cXS5UaCJwS/lHwW/ATY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB9448
X-Proofpoint-ORIG-GUID: yz3ZD11cePpfcUMrNG-7nrJ99vnD1480
X-Proofpoint-GUID: yz3ZD11cePpfcUMrNG-7nrJ99vnD1480
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-29_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305290083
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBDaHJpc3RvcGhlLA0KDQpZb3UgYXJlIHJpZ2h0IGluIGFsbCB5b3VyIHN1Z2dlc3Rpb25z
Lg0KSSB3aWxsIGludHJvZHVjZSB0aGVtIGluIG5leHQgIHZlcnNpb24uDQoNClRoYW5rcywNClBh
d2VsDQoNCllvdSBoYXZlIA0KPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHRoZSBtYWluIHBhcnQg
b2YgQ2FkZW5jZSBVU0JIUyBkcml2ZXIgdG8gTGludXgNCj4+IGtlcm5lbC4NCj4+IFRvIHJlZHVj
ZSB0aGUgcGF0Y2ggc2l6ZSBhIGxpdHRsZSBiaXQsIHRoZSBoZWFkZXIgZmlsZSBnYWRnZXQuaCB3
YXMNCj4+IGludGVudGlvbmFsbHkgYWRkZWQgYXMgc2VwYXJhdGUgcGF0Y2guDQo+Pg0KPj4gVGhl
IENhZGVuY2UgVVNCIDIuMCBDb250cm9sbGVyIGlzIGEgaGlnaGx5IGNvbmZpZ3VyYWJsZSBJUCBD
b3JlIHdoaWNoDQo+PiBzdXBwb3J0cyBib3RoIGZ1bGwgYW5kIGhpZ2ggc3BlZWQgZGF0YSB0cmFu
c2Zlci4NCj4+DQo+PiBUaGUgY3VycmVudCBkcml2ZXIgaGFzIGJlZW4gdmFsaWRhdGVkIHdpdGgg
RlBHQSBwbGF0Zm9ybS4gV2UgaGF2ZQ0KPj4gc3VwcG9ydCBmb3IgUENJZSBidXMsIHdoaWNoIGlz
IHVzZWQgb24gRlBHQSBwcm90b3R5cGluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQYXdlbCBM
YXN6Y3phaw0KPj4gPHBhd2VsbC12bmExS0lmN1dncEJEZ2pLN3k3VFVRQHB1YmxpYy5nbWFuZS5v
cmc+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnICAgICAgICAg
ICAgICB8ICAgIDIgKw0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL01ha2VmaWxlICAgICAg
ICAgICAgIHwgICAgMSArDQo+PiAgIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvY2RuczIvS2NvbmZp
ZyAgICAgICAgfCAgIDExICsNCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9NYWtl
ZmlsZSAgICAgICB8ICAgIDUgKw0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL2Nk
bnMyLWVwMC5jICAgIHwgIDYzOCArKysrKw0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Nk
bnMyL2NkbnMyLWdhZGdldC5jIHwgMjQyNg0KPisrKysrKysrKysrKysrKysrKysNCj4+ICAgZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9jZG5zMi1wY2kuYyAgICB8ICAxNDkgKysNCj4+ICAg
NyBmaWxlcyBjaGFuZ2VkLCAzMjMyIGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvY2RuczIvS2NvbmZpZw0KPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9NYWtlZmlsZQ0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9jZG5zMi1lcDAuYw0K
Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9jZG5z
Mi1nYWRnZXQuYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9jZG5zMi9jZG5zMi1wY2kuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL0tjb25maWcNCj4+IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9LY29uZmlnIGluZGV4
IDgzY2FlNmJiMTJlYi4uYWFlMTc4NzMyMGQ0DQo+PiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvS2NvbmZpZw0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9L
Y29uZmlnDQo+PiBAQCAtNDYzLDYgKzQ2Myw4IEBAIGNvbmZpZyBVU0JfQVNQRUVEX1VEQw0KPj4N
Cj4+ICAgc291cmNlICJkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2FzcGVlZC12aHViL0tjb25maWci
DQo+Pg0KPj4gK3NvdXJjZSAiZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9LY29uZmlnIg0K
Pj4gKw0KPj4gICAjDQo+PiAgICMgTEFTVCAtLSBkdW1teS9lbXVsYXRlZCBjb250cm9sbGVyDQo+
PiAgICMNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL01ha2VmaWxlDQo+
PiBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvTWFrZWZpbGUgaW5kZXggZWU1NjlmNjNjNzRhLi5i
NTJmOTNlOWM2MWQNCj4+IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9N
YWtlZmlsZQ0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9NYWtlZmlsZQ0KPj4gQEAg
LTQyLDMgKzQyLDQgQEAgb2JqLSQoQ09ORklHX1VTQl9BU1BFRURfVkhVQikJKz0gYXNwZWVkLQ0K
PnZodWIvDQo+PiAgIG9iai0kKENPTkZJR19VU0JfQVNQRUVEX1VEQykJKz0gYXNwZWVkX3VkYy5v
DQo+PiAgIG9iai0kKENPTkZJR19VU0JfQkRDX1VEQykJKz0gYmRjLw0KPj4gICBvYmotJChDT05G
SUdfVVNCX01BWDM0MjBfVURDKQkrPSBtYXgzNDIwX3VkYy5vDQo+PiArb2JqLSQoQ09ORklHX1VT
Ql9DRE5TMl9VREMpCSs9IGNkbnMyLw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvY2RuczIvS2NvbmZpZw0KPj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL0tj
b25maWcNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjMx
MGRiNDc4ODM1Mw0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9jZG5zMi9LY29uZmlnDQo+PiBAQCAtMCwwICsxLDExIEBADQo+PiArY29uZmlnIFVTQl9D
RE5TMl9VREMNCj4+ICsJdHJpc3RhdGUgIkNhZGVuY2UgVVNCSFMgRGV2aWNlIENvbnRyb2xsZXIi
DQo+PiArCWRlcGVuZHMgb24gVVNCX1BDSSAmJiBBQ1BJICYmIEhBU19ETUENCj4+ICsJaGVscA0K
Pj4gKwkgIENhZGVuY2UgVVNCSFMgRGV2aWNlIGNvbnRyb2xsZXIgaXMgYSBQQ0kgYmFzZWQgVVNC
IHBlcmlwaGVyYWwNCj4+ICsJICBjb250cm9sbGVyIHdoaWNoIHN1cHBvcnRzIGJvdGggZnVsbCBh
bmQgaGlnaCBzcGVlZCBVU0IgMi4wDQo+PiArCSAgZGF0YSB0cmFuc2ZlcnMuDQo+PiArDQo+PiAr
CSAgU2F5ICJ5IiB0byBsaW5rIHRoZSBkcml2ZXIgc3RhdGljYWxseSwgb3IgIm0iIHRvIGJ1aWxk
IGENCj4+ICsJICBkeW5hbWljYWxseSBsaW5rZWQgbW9kdWxlIGNhbGxlZCAiY2RuczItcGNpLmtv
IiBhbmQgdG8NCj4NCj5JJ20gbm90IGV4cGVydCBpbiBtb2R1bGUgbmFtaW5nLCBidXQgaXNuJ3Qg
aXQgY2RuczItdWRjLXBjaT8NCj4NCj4+ICsJICBmb3JjZSBhbGwgZ2FkZ2V0IGRyaXZlcnMgdG8g
YWxzbyBiZSBkeW5hbWljYWxseSBsaW5rZWQuDQo+DQo+Wy4uLl0NCj4NCj4+ICtzdGF0aWMgdm9p
ZCBjZG5zMl9lcF90eF9pc29jKHN0cnVjdCBjZG5zMl9lbmRwb2ludCAqcGVwLA0KPj4gKwkJCSAg
ICAgc3RydWN0IGNkbnMyX3JlcXVlc3QgKnByZXEsDQo+PiArCQkJICAgICBpbnQgbnVtX3RyYnMp
DQo+PiArew0KPj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnID0gTlVMTDsNCj4+ICsJdTMyIHJl
bWFpbmluZ19wYWNrZXRfc2l6ZSA9IDA7DQo+PiArCXN0cnVjdCBjZG5zMl90cmIgKnRyYjsNCj4+
ICsJYm9vbCBmaXJzdF90cmIgPSB0cnVlOw0KPj4gKwlkbWFfYWRkcl90IHRyYl9kbWE7DQo+PiAr
CXUzMiB0cmJfYnVmZl9sZW47DQo+PiArCXUzMiBibG9ja19sZW5ndGg7DQo+PiArCWludCBzZ19p
dGVyID0gMDsNCj4NCj5Ob3QgbmVlZCB0byBpbml0Lg0KPg0KPj4gKwlpbnQgc2VudF9sZW47DQo+
PiArCWludCB0ZF9pZHggPSAwOw0KPj4gKwlpbnQgc3BsaXRfc2l6ZTsNCj4+ICsJdTMyIGNvbnRy
b2w7DQo+DQo+Wy4uLl0NCj4NCj4+ICsvKiBQcmVwYXJlIGFuZCBzdGFydCB0cmFuc2ZlciBmb3Ig
YWxsIG5vdCBzdGFydGVkIHJlcXVlc3RzLiAqLyBzdGF0aWMNCj4+ICtpbnQgY2RuczJfc3RhcnRf
YWxsX3JlcXVlc3Qoc3RydWN0IGNkbnMyX2RldmljZSAqcGRldiwNCj4+ICsJCQkJICAgc3RydWN0
IGNkbnMyX2VuZHBvaW50ICpwZXApDQo+PiArew0KPj4gKwlzdHJ1Y3QgY2RuczJfcmVxdWVzdCAq
cHJlcTsNCj4+ICsJaW50IHJldCA9IDA7DQo+PiArDQo+PiArCXdoaWxlICghbGlzdF9lbXB0eSgm
cGVwLT5kZWZlcnJlZF9saXN0KSkgew0KPj4gKwkJcHJlcSA9IGNkbnMyX25leHRfcHJlcSgmcGVw
LT5kZWZlcnJlZF9saXN0KTsNCj4+ICsNCj4+ICsJCXJldCA9IGNkbnMyX2VwX3J1bl90cmFuc2Zl
cihwZXAsIHByZXEpOw0KPj4gKwkJaWYgKHJldCkNCj4+ICsJCQlyZXR1cm4gcmV0Ow0KPj4gKw0K
Pj4gKwkJbGlzdF9tb3ZlX3RhaWwoJnByZXEtPmxpc3QsICZwZXAtPnBlbmRpbmdfbGlzdCk7DQo+
PiArCX0NCj4+ICsNCj4+ICsJcGVwLT5lcF9zdGF0ZSAmPSB+RVBfUklOR19GVUxMOw0KPj4gKw0K
Pj4gKwlyZXR1cm4gcmV0Ow0KPg0KPk1heWJlIHJldHVybiAwOyB3b3VsZCBiZSBtb3JlIGV4cGxp
Y2l0PyAoYW5kIHdvdWxkIHJlbW92ZSB0aGUgIj0gMCIgYWJvdmUpDQo+DQo+PiArfQ0KPg0KPlsu
Li5dDQo+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9jZG5zMi9jZG5z
Mi1wY2kuYw0KPj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2NkbnMyL2NkbnMyLXBjaS5jDQo+
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5hYjI4OTFjNzli
NWMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvY2Ru
czIvY2RuczItcGNpLmMNCj4+IEBAIC0wLDAgKzEsMTQ5IEBADQo+PiArLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4+ICsvKg0KPj4gKyAqIENhZGVuY2UgVVNCSFMtREVWIGNv
bnRyb2xsZXIgLSBQQ0kgR2x1ZSBkcml2ZXIuDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMp
IDIwMjMgQ2FkZW5jZS4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcjogUGF3ZWwgTGFzemN6YWsNCj4+
ICs8cGF3ZWxsLXZuYTFLSWY3V2dwQkRnaks3eTdUVVFAcHVibGljLmdtYW5lLm9yZz4NCj4+ICsg
Kg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+PiAr
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcGNpLmg+DQo+PiAr
DQo+PiArI2luY2x1ZGUgImNkbnMyLWdhZGdldC5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgUENJX0RS
SVZFUl9OQU1FCQkiY2Rucy1wY2ktdXNiaHMiDQo+PiArI2RlZmluZSBDRE5TX1ZFTkRPUl9JRAkJ
MHgxN2NkDQo+PiArI2RlZmluZSBDRE5TX0RFVklDRV9JRAkJMHgwMTIwDQo+PiArI2RlZmluZSBQ
Q0lfQkFSX0RFVgkJMA0KPj4gKyNkZWZpbmUgUENJX0RFVl9GTl9ERVZJQ0UJMA0KPj4gKw0KPj4g
K3N0YXRpYyBpbnQgY2RuczJfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0KPj4gKwkJ
CSAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkgew0KPj4gKwlyZXNvdXJjZV9zaXpl
X3QgcnNyY19zdGFydCwgcnNyY19sZW47DQo+PiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2
LT5kZXY7DQo+PiArCXN0cnVjdCBjZG5zMl9kZXZpY2UgKnByaXZfZGV2Ow0KPj4gKwlzdHJ1Y3Qg
cmVzb3VyY2UgKnJlczsNCj4+ICsJaW50IHJldDsNCj4+ICsNCj4+ICsJLyogRm9yIEdBREdFVCBQ
Q0kgKGRldmZuKSBmdW5jdGlvbiBudW1iZXIgaXMgMC4gKi8NCj4+ICsJaWYgKCFpZCB8fCBwZGV2
LT5kZXZmbiAhPSBQQ0lfREVWX0ZOX0RFVklDRSB8fA0KPj4gKwkgICAgcGRldi0+Y2xhc3MgIT0g
UENJX0NMQVNTX1NFUklBTF9VU0JfREVWSUNFKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiAr
DQo+PiArCXJldCA9IHBjaW1fZW5hYmxlX2RldmljZShwZGV2KTsNCj4+ICsJaWYgKHJldCkNCj4+
ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgIkVuYWJsaW5nIFBDSSBkZXZpY2UgaGFzIGZhaWxlZCAl
ZFxuIiwNCj5yZXQpOw0KPg0KPlNob3VsZCB3ZSBiYWlsIG91dCBpbiB0aGlzIGNhc2U/DQo+DQo+
PiArDQo+PiArCXBjaV9zZXRfbWFzdGVyKHBkZXYpOw0KPj4gKw0KPj4gKwlwcml2X2RldiA9IGt6
YWxsb2Moc2l6ZW9mKCpwcml2X2RldiksIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAoIXByaXZfZGV2
KSB7DQo+PiArCQlyZXQgPSAtRU5PTUVNOw0KPj4gKwkJZ290byBkaXNhYmxlX3BjaTsNCj4NCj5B
bnkgcmVhc29uLCBub3QgdG8gdXNlIGRldm1fa3phbGxvYygpIGFuZCBtYW51YWxseSBoYW5mbGUg
a2ZyZWUoKSBpbiB0aGUgZXJyb3INCj5oYW5kbGluZyBwYXRoIGFuZCBpbiB0aGUgcmVtb3ZiZSBm
dW5jdGlvbiA/DQo+DQo+PiArCX0NCj4+ICsNCj4+ICsJZGV2X2RiZyhkZXYsICJJbml0aWFsaXpl
IHJlc291cmNlc1xuIik7DQo+PiArCXJzcmNfc3RhcnQgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGRl
diwgUENJX0JBUl9ERVYpOw0KPj4gKwlyc3JjX2xlbiA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwg
UENJX0JBUl9ERVYpOw0KPj4gKw0KPj4gKwlyZXMgPSBkZXZtX3JlcXVlc3RfbWVtX3JlZ2lvbihk
ZXYsIHJzcmNfc3RhcnQsIHJzcmNfbGVuLCAiZGV2Iik7DQo+PiArCWlmICghcmVzKSB7DQo+PiAr
CQlkZXZfZGJnKGRldiwgImNvbnRyb2xsZXIgYWxyZWFkeSBpbiB1c2VcbiIpOw0KPj4gKwkJcmV0
ID0gLUVCVVNZOw0KPj4gKwkJZ290byBmcmVlX3ByaXZfZGV2Ow0KPj4gKwl9DQo+PiArDQo+PiAr
CXByaXZfZGV2LT5yZWdzID0gZGV2bV9pb3JlbWFwKGRldiwgcnNyY19zdGFydCwgcnNyY19sZW4p
Ow0KPj4gKwlpZiAoIXByaXZfZGV2LT5yZWdzKSB7DQo+PiArCQlkZXZfZGJnKGRldiwgImVycm9y
IG1hcHBpbmcgbWVtb3J5XG4iKTsNCj4+ICsJCXJldCA9IC1FRkFVTFQ7DQo+PiArCQlnb3RvIGZy
ZWVfcHJpdl9kZXY7DQo+PiArCX0NCj4+ICsNCj4+ICsJcHJpdl9kZXYtPmlycSA9IHBkZXYtPmly
cTsNCj4+ICsJZGV2X2RiZyhkZXYsICJVU0JTUy1ERVYgcGh5c2ljYWwgYmFzZSBhZGRyOiAlcGFc
biIsDQo+PiArCQkmcnNyY19zdGFydCk7DQo+PiArDQo+PiArCXByaXZfZGV2LT5kZXYgPSBkZXY7
DQo+PiArDQo+PiArCXByaXZfZGV2LT5lcHNfc3VwcG9ydGVkID0gMHgwMDBmMDAwZjsNCj4+ICsJ
cHJpdl9kZXYtPm9uY2hpcF90eF9idWYgPSAxNjsNCj4+ICsJcHJpdl9kZXYtPm9uY2hpcF9yeF9i
dWYgPSAxNjsNCj4+ICsNCj4+ICsJcmV0ID0gY2RuczJfZ2FkZ2V0X2luaXQocHJpdl9kZXYpOw0K
Pj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byBmcmVlX3ByaXZfZGV2Ow0KPj4gKw0KPj4gKwlwY2lf
c2V0X2RydmRhdGEocGRldiwgcHJpdl9kZXYpOw0KPj4gKw0KPj4gKwlkZXZpY2Vfd2FrZXVwX2Vu
YWJsZSgmcGRldi0+ZGV2KTsNCj4+ICsJaWYgKHBjaV9kZXZfcnVuX3dha2UocGRldikpDQo+PiAr
CQlwbV9ydW50aW1lX3B1dF9ub2lkbGUoJnBkZXYtPmRldik7DQo+PiArDQo+PiArCXJldHVybiAw
Ow0KPj4gKw0KPj4gK2ZyZWVfcHJpdl9kZXY6DQo+PiArCWtmcmVlKHByaXZfZGV2KTsNCj4+ICsN
Cj4+ICtkaXNhYmxlX3BjaToNCj4+ICsJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOw0KPj4gKw0K
Pj4gKwlyZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBjZG5zMl9wY2lf
cmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpwZGV2KSB7DQo+PiArCXN0cnVjdCBjZG5zMl9kZXZpY2Ug
KnByaXZfZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPj4gKw0KPj4gKwlpZiAocGNpX2Rl
dl9ydW5fd2FrZShwZGV2KSkNCj4+ICsJCXBtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKCZwZGV2LT5k
ZXYpOw0KPj4gKw0KPj4gKwljZG5zMl9nYWRnZXRfcmVtb3ZlKHByaXZfZGV2KTsNCj4+ICsJa2Zy
ZWUocHJpdl9kZXYpOw0KPg0KPlRoZXJlIGlzIGEgcGNpX2Rpc2FibGVfZGV2aWNlKCkgaW4gdGhl
IGVycm9yIGhhbmRsaW5nIHBhdGggb2YgdGhlIHByb2JlLCBidXQgbm90DQo+aW4gdGhlIHJlbW92
ZSBmdW5jdGlvbi4NCj4NCj5JcyBpdCBvbiBwdXJwb3NlPw0KPlNpbmNlIHBjaW1fZW5hYmxlX2Rl
dmljZSgpIGlzIHVzZWQsIGlzIGl0IG5lZWRlZCBhYm92ZT8NCj4NCj5DSg0KPg0KPlsuLi5dDQo+
DQo+PiArc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIGNkbnMyX3BjaV9kcml2ZXIgPSB7DQo+PiAr
CS5uYW1lID0gImNkbnMyLXBjaSIsDQo+PiArCS5pZF90YWJsZSA9ICZjZG5zMl9wY2lfaWRzWzBd
LA0KPj4gKwkucHJvYmUgPSBjZG5zMl9wY2lfcHJvYmUsDQo+PiArCS5yZW1vdmUgPSBjZG5zMl9w
Y2lfcmVtb3ZlLA0KPj4gKwkuZHJpdmVyID0gew0KPj4gKwkJLnBtID0gcG1fcHRyKCZjZG5zMl9w
Y2lfcG1fb3BzKSwNCj4+ICsJfQ0KPj4gK307DQo+PiArDQo+PiArbW9kdWxlX3BjaV9kcml2ZXIo
Y2RuczJfcGNpX2RyaXZlcik7DQo+PiArTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGNkbnMyX3Bj
aV9pZHMpOw0KPj4gKw0KPj4gK01PRFVMRV9BTElBUygicGNpOmNkbnMyIik7DQo+PiArTU9EVUxF
X0FVVEhPUigiUGF3ZWwgTGFzemN6YWsNCj4+ICs8cGF3ZWxsLXZuYTFLSWY3V2dwQkRnaks3eTdU
VVFAcHVibGljLmdtYW5lLm9yZz4iKTsNCj4+ICtNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+PiAr
TU9EVUxFX0RFU0NSSVBUSU9OKCJDYWRlbmNlIENETlMyIFBDSSBkcml2ZXIiKTsNCg0K

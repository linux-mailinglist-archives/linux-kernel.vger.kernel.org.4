Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FB66C880
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjAPQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjAPQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:39:21 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C80EC48;
        Mon, 16 Jan 2023 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673886476; x=1705422476;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eMfHasH0M7FN55Mbydp+4GhKb3wl30R1jzA49sErp1w=;
  b=bur/rEB7gj3ksEKhHwTLirTVsXMGdIv6PuzS7iLRcKb9xQTNQpr06XfQ
   rvOAEclNdYevb7rRObnIvfblUbkQxTHPFgNPwy9OsInl9LQY9Jz5uTA38
   IP51zmyggvtDosUt1jenWI6fMwyaH0yBy2EMk/vgNz/AJub4hSuFTYZTf
   ilBElkQEKKVWk1b04NTS+fYxwLvlzmPvL0yLnvk/5y4UF6f7trC75xikT
   ZkWuf8/52VtJk2Swf+2yZsuHZE713XHbtG4mRaAnLz6sjm8Ux49YUIicS
   SnKaexb1OUIlBZtgx3hPBtwQLsptYq0q+iS2EJ/b0TZ5zGppfxNPl/E4p
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,221,1669100400"; 
   d="scan'208";a="197010137"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jan 2023 09:27:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 16 Jan 2023 09:27:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 16 Jan 2023 09:27:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmtDISQM7399qZju9u2PfvvonhyT42DSNIF0fT0ZA7vGyKSZqR1g5QYRVpe1ti2Ce33fLdWp8MfFLYLRJs0DlPyT9Ww058SD+qkYD7IPavrJiAdHgB14IqEDMecKGx8jgk2FHiaapa5xlBfUdQ68ApUza/SqWXRea8pjGXMC6cr4DY4F1AUWKdBklMQR+c8J/3+/yvyDmoxW2Pb3S0Zs0xlz7ffPZMAJir6CQLdd//adNQPJlm2F03S3qJk3qBqooi8w2+mIHzkIo/ARuzsz4+AZTQNnl1/6C2hPJNPy9JGTR0VwQCmWxy9q6Un3OWiwuLrXZ7gjzHMt308iXOj1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMfHasH0M7FN55Mbydp+4GhKb3wl30R1jzA49sErp1w=;
 b=oWlswpbZ9ZWCjkTugYd756FFtc4NI3uzPcAdcRExf4izQwPRN/6M/kSpj5wzMsEM4kPqi5J2/Qxi+EBI4WbxhCk0Jgaw0sOxyrp2C4L1Bg/WgvQ2iN7tyH09YDUt9VHrF2Krrt/1LVyXi4Peg9beRs+DemFUm8k9vPm9oOgVXd6w+88aIxiNNa4Z3JWtSnC+rtHYw9QJmuJhGIIlHPANSEZu+CloNmEZWPOP2g9fY3nE9FPUU18Lo1CfXPTwDK4C90V8pv9c0sFZpleznVniXR/jehoVHGtU9d8obXibb1zuk5d2R2H+o6c9kBiXKWwINoWqCYl3j9djmbCnK9KvSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMfHasH0M7FN55Mbydp+4GhKb3wl30R1jzA49sErp1w=;
 b=PAKy9OK/NRaPqkl2+A9v6MaOmbFU5z4JR+B2mGb0phMSnu+h1rV634cxTe+rdByUvH0HlNUvn6+Rn62vFwlRP02cAPzXm67YzqWNb6yS2wTqFjdi9MV7eu4N/41R0pab6R3uRlEKqEMNwsUOF+9zgk9WlVlzaIHOtSGbEBLPRDY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 16:27:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::3758:fd2d:5bd1:9758%6]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 16:27:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <peter@n8pjl.ca>
CC:     <ardb@kernel.org>, <linux-crypto@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Thread-Topic: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Thread-Index: AQHZKb1Ircg9ldBh70+DvhGuIDV4cq6hJXQAgAADV4CAAAMvgIAAAkIAgAANPAA=
Date:   Mon, 16 Jan 2023 16:27:50 +0000
Message-ID: <5dc3e3c7-43c2-7344-4b77-4845df072ea6@microchip.com>
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca>
 <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
 <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca>
 <Y8VuB7kmn9dQ8/en@wendy>
 <dmhKJenSmPJOEexgrs2dFRol14c34HKqMXwGjS-CXVJKZ2hCmR5yN1BG8osscOQvgJaR0wx2AOenX5Zkq34TPpf1BJ9a6zB7ZN79N51wOTI=@n8pjl.ca>
In-Reply-To: <dmhKJenSmPJOEexgrs2dFRol14c34HKqMXwGjS-CXVJKZ2hCmR5yN1BG8osscOQvgJaR0wx2AOenX5Zkq34TPpf1BJ9a6zB7ZN79N51wOTI=@n8pjl.ca>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: ed5ffc26-749f-4f4e-4d7c-08daf7de9c6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ihEi/y7orhSvXYCSitS09rna7+5oqeb/qEpNSRseSVnh/C2cZSBjHcU0GHvwr9uon/FooHJH8vkplJ93aeg/74KGPNwtbZFoIyPwX/8Ny39vPqY+2CVbruZOXyQRfbR45T3J6LqG4cnC9BVaUpxDEzNOdNdp4RSxLSwh+245Er7c+8wJBLM0h8AVDrz53DoTm9ysI7Ns565wPqY2x5F1gTC1vauHhbIpwr9p8F+pk0zIZc5EsIdNVQOBg1WHhimtO5AIbixyx4CMmN7CwfHnpwmSq9tvvvHCD7/EZeVZtiPZHqimky1YEdDjJBzj1ImDReXfMVpl6jM7C8JSodr+uiLlMSfpNe0H48jwqgButLWfxtr6uf/mYmVoIQYG2qND3Ev//nUB7CdubDVJ+ebzosvx1WO/vhEGQsNzOWDLw4X3ChsILx6RkqPU/y8VLEOvRLgeJWw7iC0o5wlLP136ToRS9DM8E1rZHWnWijyjuA+YcC1QPruGrhVKkxLoUwKYlw79WlHLRJNt30sPtAPKRyEATaD3eGDcCAL9z2IifLBIjms8tSSswCusvDAt0aUsM+c3CB5IhoEQE+0OO+NlB7PXohNi1WquZD1YuhgfbIQMr8Ky4Z24SUOtc5EEGR2O37fHRGM74cM1wW2Cj6GWPWUtMbEuiRR6jqUf+/8oFZ2mIfEcJ7ByGn4QTdcFt1Y8dmY5sFQZ+aV80CmWm1PYOgnbPtqT00VGUwwLQQiluygvGiEUPnIBgQDzZqxzSeTKAwXiRAkYlmZqyZ0L2MViAvWycqRQjZqOgPNaFHdTxPi0vAscxzAgSMCNr+TUNs+AWaTo+wvitWoP0eatEvuyTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(31686004)(36756003)(6916009)(38070700005)(86362001)(76116006)(8936002)(66556008)(31696002)(64756008)(66946007)(66446008)(66476007)(8676002)(4326008)(2906002)(83380400001)(122000001)(5660300002)(38100700002)(966005)(71200400001)(316002)(54906003)(6486002)(41300700001)(478600001)(91956017)(2616005)(53546011)(6512007)(26005)(6506007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qjd2cms5RGVROWRIMGZ6RGRYOEdhZXdSNllvT2pvUzBMMlNOK3IrWU96UkFO?=
 =?utf-8?B?VTZKRUNDYXRIVzF0UTZoNVlYWEJGb2ltV2djOTZwdjBXWkd6bTZNNndKcE5D?=
 =?utf-8?B?SUQxYjRsa3BFRXFVOE13MHpnMjZtWG9qaDg4VUJzaFZ0UXUyNzVmV1hPZy9M?=
 =?utf-8?B?VFBWdjlkeUtkS1VRKzhSbkg5Nm5BaUFQbEpEME5mT3hOb1FITmd5UlkzUUdj?=
 =?utf-8?B?Zi9SNWZQMjFxcVlLbWJWcGVQcGhMN3AvaGxsOTh2RUFRRjNlSWxuZlEwZWU0?=
 =?utf-8?B?QkRwaDM3bmFHU2dBTVp6L0V1QVNucnJjWlREeURMRjArdElYdkRXd2R1SEFD?=
 =?utf-8?B?RmQ4cldPZG8xMFIza2FBOG5pemdTbDlnajBQRWR5a0RZeHJJSkl3LzVETUEw?=
 =?utf-8?B?bkQvcVcvTHc0SU5jT1h0TUJXQ3B0QVJxT1YrQVBKcGZndTBuVFk5YktRL2hK?=
 =?utf-8?B?S2hadkxaM2RGWHN6eW91dVdXVXBSUHFjR1dWcjV4SVNEZWZIeGdSV2tXNkh5?=
 =?utf-8?B?cmdiL3FtTmlnS0JnckFkQWt0V3haQWVWUWFDY2pJWWFxUG9mNTRndnlzd3BM?=
 =?utf-8?B?NWVuYkt6MUhFKytGZXBBTVdPTHJNeVh0SnhndDE0V0RzYkNtQ2d0eWNOSE1I?=
 =?utf-8?B?bG9vclBRclZtdXpVOThtbnBxQWhwTG9DbmdFSnBWaktjOTVXcGo3YSt3eHFV?=
 =?utf-8?B?MVVYa3FpU052NE1rMW42Vjk2aUpqcy84U1RKL29PUWpiZVBqUjhGbDRlVitE?=
 =?utf-8?B?dXNLcDlseFRqMUtqTnV2R0RERWNZR1FsYlFpZmV5cXh3WVJUcFlVWTRONDhZ?=
 =?utf-8?B?SWt1Rkt2aHBQWVhXTklpWkdkSldlS3ZTcTBGdG9jMTJJMDF1ekpBdnpMWlBM?=
 =?utf-8?B?Vk1jVDN0Wm9vMFg3b1FQMWlSa2dsL0h2bSswVWVRcUhQckYreXllRDJoTDhX?=
 =?utf-8?B?bGc3QzJhb1IzQ0pwM2xFS0FWOXlWeEM3ODdlSGZWY1ZSUUVCeXdlNG9VZmlK?=
 =?utf-8?B?OXRiVTZmbjRqSXY1SXFoQWhqamJFaUt2UGx6Vm5za2xXaitZRUEvWkZwMWoy?=
 =?utf-8?B?dHAxdFpERjFmL2lRNlM4N0FIQlBtdE80ZHREU1hGb1NqR1htUTlYb1ZOTXlR?=
 =?utf-8?B?VTA5YVEyYUFJSlF3ZlBHZ2RCdzNsR2poOEowTk1qOWZOUG9FZkhVQWcyb1li?=
 =?utf-8?B?ekJYR1lsNFZ4VXhXR21lQ1BJSlhmblJKdDFTNnNpVzM3RkprQzB5cnpsL3g1?=
 =?utf-8?B?b2VSQXVDRTlaQ05QdWZnRnkxZXM0bURYbEZoSUZtRGhVMzhBNk9mRFNCcmpT?=
 =?utf-8?B?aE52Vm1WdGN3V3pmQUJ2MFVYaFMybzRYbjZTY3JSNDNESlFCWW5yNnU1cGw5?=
 =?utf-8?B?Qm1DN3RpZE5NVEY4VG1FdXlDdTZ3UVhJU1hqUnpZMEk4ZWhid2x0S2RZQTIy?=
 =?utf-8?B?M0lwV210bDd4MHM4OWh3Rnl3L0JzS29CNHA0NGJrVjMzM2ZzRU5WQnZZYWpT?=
 =?utf-8?B?Y0NoOXE4Ym5HQ2Q0UmpkTUZ5S3ArOTNRNjFKanl0QWxCek14UmdhSW9FRHhj?=
 =?utf-8?B?alhuVDBsNFJlZUdhcmY5T3doTDQ0U29DRHpXYWM4WGhlMlc5Y3NDZU4zYWx5?=
 =?utf-8?B?Uk5jekQ3N05paC9CM2RMOXRtNjlwWi9jRjBGNUhlajgxWHAzcmtSclRuZit6?=
 =?utf-8?B?YjBqZ1BaYzVUb2ZxOVV6WDl6b1pLMDNIcVdSOWl6WG93RVJEc2pjV0gwRHVr?=
 =?utf-8?B?NE1CRk5Yd2dBd05YMWtzM0FaR3ZSeUpLQjMrU01Vck9QeTBmUDBMbTdYMFFu?=
 =?utf-8?B?YXhOeS85OStReEprcisxTjU5ZFo2UlhlSUlBWkFGM2V1bURIcjFPMkVNYWNH?=
 =?utf-8?B?anpMUC9Id3NKc0RydE9UQkpzd0dyTUp2WXErdUtrY2o1RitjaEt1S2JaWUxl?=
 =?utf-8?B?UDlFZkxuTnU1MCtrUlY0c0pndk05dEZ4dCswSXdEWnk3OUUwREpxZmxSa2ZG?=
 =?utf-8?B?cTNGZStuczM0NTNaWE8ySFpkanlzY3YxbytuUkhmT0x5V3Q3Tm94Sm04a1hK?=
 =?utf-8?B?d0VTZmlBbFQzaXV4ekJrbE5oTnJRQlRVVklCWEZCWHh1aHJUcjhKNUUrOFRF?=
 =?utf-8?Q?qvn5msPUwl5Chmzsfyd1L2ixT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F059F79D5676BE429AF69F8F63040E5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5ffc26-749f-4f4e-4d7c-08daf7de9c6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 16:27:50.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y08PqO+cih6oC2t8puXcWruel0Sx4Ksr/s96QdX2zHTmSayo05tCcdYXH8wJEZHdNEx8hx5/sk4JAN5palpt0BWXurCVUmwMCr3KiuURuBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDEvMjAyMyAxNTo0MCwgUGV0ZXIgTGFmcmVuaWVyZSB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4+IE15IGFwb2xvZ2llcy4gSSB3YXMgaGF2
aW5nIGRpZmZpY3VsdGllcyBjb25maWd1cmluZyBnaXQgc2VuZC1lbWFpbCwNCj4+PiBidXQgbm93
IEkgYmVsaWV2ZSB0aGF0IEkgaGF2ZSB0aGUgaXNzdWVzIHJlc29sdmVkLiBGdXR1cmUgcGF0Y2hl
cyB3aWxsDQo+Pj4gYmUgcHJvcGVybHkgZm9ybWF0dGVkLg0KPj4NCj4+DQo+PiBJdCBsYW5kZWQg
b2theSBvbiBsb3JlOg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY3J5cHRvL0lC
b29UbEdXcE5FN3BPZWx0MGdtMjFieFc3d0JJTE5ZSjFIYW9QYmJmZEVFTXd6MFBwOTJ2cGRfT1Vs
aE5GTkFpdEZUaFRpMjdQNnE2TnZjWU1LbS15N3Rqd2lGOVliSW1XamhnQzNVRE1rPUBuOHBqbC5j
YS8jdA0KPiANCj4gWXVwLCB0aGF0J3Mgd2h5IEknbSBub3QgcmVzZW5kaW5nIGl0Lg0KPiANCj4+
DQo+PiBJJ3ZlIHNlZW4gZW5vdWdoIG9mIHRoZXNlIG5vdyB0byBrbm93IHdoZXJlIHRoaXMgaXMg
Z29pbmcsIEknZCBiZXQgdGhhdA0KPj4geW91J3JlIGEgcHJvdG9ubWFpbCB1c2VyLi4uDQo+IA0K
PiBZb3Ugd291bGQgYmUgcXVpdGUgY29ycmVjdC4gVGhleSBkbyBsaWtlIG1ha2luZyB5b3VyIGxp
ZmUgZGlmZmljdWx0IHdoZW4NCj4gaXQgY29tZXMgdG8gdXNpbmcgc210cC4NCj4gDQo+IEFueXdh
eSwgdGhlIHBhdGNoIGxhbmRlZCBmaW5lIG9uIGxvcmUgYW5kIHBhdGNod29yayBhbmQgSSd2ZSAo
ZmluYWxseSkNCj4gY29uZmlndXJlZCBnaXQtc2VuZC1lbWFpbCBwcm9wZXJseSwgc28gSSB0aGlu
ayB0aGF0IHRoaXMgc2hvdWxkIGJlIGFsbA0KPiBnb29kIG5vdy4NCg0KVW5mb3J0dW5hdGVseSB0
aGF0J3MgdGhlIG1vc3QgYW5ub3lpbmcgcGFydC4gUHJvdG9uIGVuY3J5cHRzIHRoZSBjb3BpZXMN
CnRvIHNwZWNpZmljIHJlY2lwaWVudHMgb25seS4uLiBTZWU6DQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMjAyMjEyMzExNTIzMjAuMTM0MDg3NC0xLWNvbm9yQGtlcm5lbC5vcmcvDQoNClRo
YW5rcywNCkNvbm9yLg0KDQoNCg==

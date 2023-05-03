Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3656F549F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjECJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjECJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:25:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C581FE3;
        Wed,  3 May 2023 02:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvlX7UEnXA0egoqBXzFjTHIDCx1hUyHah9O4izrOJWqOvUVoe4KeQsvuPYuMlqJzmZftYzvEa2zyMylBqj4/Y00S3V9whpMMlYjb38oFs+AKz2Iv+OLFzIkDaeZYzSaCNs+DfUkHP45kMCvfMg5Cbk+e3blUlQG2xANiyICB6nSmnMtt44utq4OI5ntrjus14UIzkY+RjQsQwIj83XKqH3QDWX109AvE4bD0MNUvdu96kftpQJUUqXVfWNmbMlm109hRcMfQtowdB2cM6o2hKLXNp7UBdja6E8cSDS8xSRI/JjyT8MXAaZLmeEm+q0MK/ZMx3w5ymc0ogPFJzgD3mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0tjupqUTMATGKI6eYy6/pT+R5UyYfnpUFKkYDi/Wk8=;
 b=YAGuBdTC8h8FKqDvkpRqFYHAE7kSjnjT6CG8Fi6GfuJcs2V8LE6E1kZQ96VM1kVICR7QXhZtS4DXFY6vmb6vXSQYjHWAgxHNBaNYHUXcvERXDqNeO9PySR2ao5tSIf7ppc6x+Hh41vIVoP4CJ1dFdKCLtxu1oTdNcC5EklPYs/Mn8GinwYIzyjW/QbEY2V+5Bt1z9S68W1wwLu63JEjDaubYAum8HxUl1gLlDwu6MgtRdJzw4d/gjXWrUptnwlmOi7FwzJAOJFPK5v+sms+rGDcAPO4RWgrwsyQ37QMv5MIa7Z2dHQggcAoP0IgkRoLQIToBrR6IAohsNI0BJrM4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0tjupqUTMATGKI6eYy6/pT+R5UyYfnpUFKkYDi/Wk8=;
 b=PfSvSxEpfEO28hxRdiMGvgJmDkZxC0fij5Nfg1hklg4hBC4qy0KHFD7olLPDXWicHz5bGG1d7sXNp//aUVopUFtaqEFztX3qgCilyN0BY3IGyESFt7JdGRqXYmbuMLiCB8DGDP1qmAasVSzRxi/dGOSNsD4RT68sOjCXVAJbxoXCfV+7YQYkP1fdePiWFYK1KBvlp4FbgMQ6jfuXDkWZJDKqCoF3IVnc56p+rFdeY7PDBiTBcLBVsmDoWpruE6lKc+ejSakstRBoMwDYfKobKU3n/GqoCwd8qjP/Uk2faPizV/CoTxicXHR1HTHyUalPqaRxb7zqkDfqCZKOer+N0Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH0PR12MB5217.namprd12.prod.outlook.com (2603:10b6:610:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 09:25:20 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6363.022; Wed, 3 May 2023
 09:25:20 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Daniel Wagner <dwagner@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v3 03/12] common/xfs: Make size argument optional
 for _xfs_run_fio_verify_io
Thread-Topic: [PATCH blktests v3 03/12] common/xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Thread-Index: AQHZfZW2Ivo341wMiU6xiuwHnJFy/K9IRy+A
Date:   Wed, 3 May 2023 09:25:20 +0000
Message-ID: <a7615303-aa74-15bc-ed77-a09e2420df79@nvidia.com>
References: <20230503080258.14525-1-dwagner@suse.de>
 <20230503080258.14525-4-dwagner@suse.de>
In-Reply-To: <20230503080258.14525-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH0PR12MB5217:EE_
x-ms-office365-filtering-correlation-id: d04a8470-2e71-4f30-ef49-08db4bb850a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5j6D0fReSw4N4vHVOes+Ud3fL945YAjopMtbALrNmN5pnFzUJ/NOe53/r0UbqVot92WD6Qle9RxV1VnTrNa/zr4lHUE2+Alz1rpMwXwCRF/1BxCey7AiEYsGDEuekOIAV7Y8dDIymjpbH2fbFPHQ+rJ+yWE7kwlXTtNNFf+YVWLm1xi+ruZS7ZxpWg8krKvCdWCEsNREVbn+J3VhdRLGaG7PcmSQnzWI0zDBR0Q5SaT2M0jg3nhR9ZaoBJaqKmNmwbHxR7VrDWX/ylXV62HBdgB0ptGEyTXLNywTlmvkuGjb7QWKMaoU8QDjDmsllSsO2zTVF7pSUY0YVXBTYwvCKRiZAPkpIjmr+cF1jO/RzGt8fGzqO92064/ciZ0+sgwPQiSmYPBZtv51Dvzwz5LfkfdwwS8Z1upAcZu+XNcEu60WPcXeIdEDq5Pax86UhDLlHM220KfF0caGPsRuCB/yaoIiUcrivalVsHA8k9sOuSpAet74ip+yY55+kpW+FZ/V/ZjHlioEqfnx/mzMX8kVfEh4nK2lH+lNMtmIGKf6TVFNpuVTcumgz/gk3yBv/UxdBKA+fqSu1+rIVsu+oTkngADS5juuM3Hh04yDY0bS63HZGInfCoUYa1gP3/KP+AAbP27xPfH8FzbEN93fz2uyZD3Ceq6FWEuxIfSA4uyCTs6INUwva0xWKxB/RlH8VRB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(31686004)(6486002)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(66946007)(71200400001)(478600001)(91956017)(316002)(54906003)(110136005)(31696002)(36756003)(86362001)(53546011)(6506007)(6512007)(8676002)(8936002)(5660300002)(4744005)(2906002)(41300700001)(38100700002)(38070700005)(186003)(122000001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUlBQThlUFNDdklVMTcvQnlkV05GY3J1T0tNL1JhcWxLQ0s0SjhrVlNhVkZ4?=
 =?utf-8?B?ZktSQ3RReXNxMi9YcDF3WGJENEJlZk5ZSjA5T01vQ0hPRUhSeHRtWUZVVGJZ?=
 =?utf-8?B?Wk91N1Y4d0FqTE9Bays5V0ptUDZJWTlLWE5ZWUc4S29MRzZpRkNjNzR3akF0?=
 =?utf-8?B?ZjdEZU0wbkdHaklwUGJNWGtmOThTVTFvZUNUU0VldFFuby8xLzNNdXQrcjhQ?=
 =?utf-8?B?UHFFUndPd2tpNFlJd0FiREJ0RkV0K0FMbHZYcFc1R3dNNnZRdkQrZnAzYUJQ?=
 =?utf-8?B?a1lrdEpuaFNVa0NZa3huRXhqMmVKWWwydWEyRlIxSHVvWlh5Z09meDBxNkZs?=
 =?utf-8?B?L09FRVdxbTlTc3htemhraHJaZ2hoTE5IQWhBa2JySHJpYnJMMEZ6WG9DT0Vk?=
 =?utf-8?B?THR0czhFTno2TXJrUUJQMTA5SDI0b3dXV1oxYWJqNndTTXB2NTNSc3ZHOGpx?=
 =?utf-8?B?MHJZUmY4cnpzWXd3TkpVZkpidkhuRmV5SEt4b0hqRmQzcVR5bkdzYjVnZEk5?=
 =?utf-8?B?RXNnUUtyWVN3WlJDY2d5YmFVWG1jR1pIQkllU2w5N0JGRmx2TllwamtCQXp3?=
 =?utf-8?B?V08wb2R2SmJmem5la3B4TG1ScWg2cmJjNWtBUVdySEJmL0taS0s2bkVxS2JF?=
 =?utf-8?B?aDJOUnFCZVprMzlMRjRKczlyZ0w5VVNia283RHNGZU5QZDc5NHdnb2hEV0F0?=
 =?utf-8?B?WFZudnkxM3FpTW9zbzBBU2lvYUcrOWZnWi84ekg0WmdsdG5iWW9xejVIK1VB?=
 =?utf-8?B?OExoR001M3Avam9saGpPeGxmMFkyWThJbnlPQ3c2dWxyUm1pdmNHNWpiSElU?=
 =?utf-8?B?cGVWU3EwbGdVcDRQM0YwZlEyM1JSKzJUbFg0eXR4SHJFQldUK1pXcWhtSTcy?=
 =?utf-8?B?bUhqTDliV3BWUkRqdE8vRVZYc05RaGlTNjdqeUdlaTBDV0htZndoYVgzenJj?=
 =?utf-8?B?aTIzdEd6eGVHU0xmQ0pEamU5Wk42d3haUDRXanhQK1lyNWtId0tkcFBWN2Ir?=
 =?utf-8?B?aUhvYWJZTVgyVHBmbXBmbDg1UXVnMVdXaE1VZTR4TjRJM25QdVg2eDNxcHVJ?=
 =?utf-8?B?Zm9meHMxYzFsSENnOXVYQVJHM2dWVmVvcnlNRVpEc0VnbXp0QWdlbk9HWFQz?=
 =?utf-8?B?Z2Y0MWJqNWxnOXNVaHEweG5sSU5OWGpiWVdjMlNIZnI0TFl5WEpKNmh0ZTd6?=
 =?utf-8?B?TmpDbGJYdSszTFpiU1d3WFFpbXAzbjlVVUx3Y2JZMnZuM0ZzUkRyY2hBOG8r?=
 =?utf-8?B?UjdzbmV6VExDZTNVNDNoaFlmZzRSMlFFQnJJUUEvV0hkMlVoZzRYZFlUWjNx?=
 =?utf-8?B?T245NDFxZWsyaHNLN1VmdGUwRGFDUnAwQWJFckF2Z21XN0xMSDRLU2NJaVV2?=
 =?utf-8?B?UXViOFFUMkVpaUpxSk5ISFYzOVl2bk9KbWFkeHN5UFZLTzByU0l3cEMvOHFq?=
 =?utf-8?B?b3gwSThwby95RXlKclRRUW1mazhaMmUrcXZIckxqd2ZKcFJJcTl4djNxNlBz?=
 =?utf-8?B?anRHTm40bGZpQlpYeFlkZ0dkZXI0QXBlM0Y0eHh0dUVBNjZ6eG0yNU5Xblpq?=
 =?utf-8?B?RGZEbXVjUStuUHRTWXdtTnMyclp6bUNBNzJmWHdKU2w4YUpSY1VXZk5lL0Zk?=
 =?utf-8?B?R3MwZU9uakFpOGdGdlFCMkV2SGdHY0xmYlc3TmhkazQzY2U0UnRkYngvZmJM?=
 =?utf-8?B?TnZyeW9xdkJDbjZuU1FIcVdPM2ZNRGlINE56bm0vYVlydXhIUHFhV0VXSmZP?=
 =?utf-8?B?Lzh4MXdObnFpVnV1dGVHd0ZqSHZOZVM3RTFZdnNSS2FkZ3JVWHN0QW9CRkpO?=
 =?utf-8?B?U00yK3BPVUtVdXlMU1ppV25kK2txZlMyY3NuKysxQUVnRVorMjZ3K3Fib3JT?=
 =?utf-8?B?dVM0QzFJbVRHVjZxT0QrNDdsNkp2ODg3czg5L240ZkVtd0p4U25haFdMUFVT?=
 =?utf-8?B?ZGJIT2J3aXZ5c0xRaFJ2cmNMOVArSExuV1BHSVFpcVphRXhlMklGTzBlMWlp?=
 =?utf-8?B?NVNteWNhYUEvRncrSGlwQ01vUE1NN3ljWUF2QnJjQnBqYWM1Q2lhVzFxUWZR?=
 =?utf-8?B?MzBUT1lMOHBzVzlPaWxjVHMzY09hbmxiTE1zSWJlSFNBKzhpVG1ibjNXRDNa?=
 =?utf-8?B?bWU3eVdwYjhSZHBMcnFaRU9LK3BsVjJINmxkZnNpTitKNTBKWWlER0ttYkRP?=
 =?utf-8?Q?evM6bb04INBAt0YQKpML/4P86ug6Xy49vTAm7cUCAY/Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66D79963B111004B81AA0E449A5640A4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d04a8470-2e71-4f30-ef49-08db4bb850a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 09:25:20.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkNGcU2U9ZKuE0mBxsY1Tb2YTM8FLA3cbralzi50cZAeSBH0C4NZDkM6/3+0mQGAHKf7UcPJBy5351QJBMLg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5217
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zLzIzIDAxOjAyLCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBNYWtlIHRoZSBzaXplIGFy
Z3VtZW50IG9wdGlvbmFsIGJ5IHJlYWRpbmcgdGhlIGZpbGVzeXN0ZW0gaW5mby4gVGhlDQo+IGNh
bGxlciBkb2Vzbid0IGhhdmUgdG8gZ3Vlc3MgKG9yIGNhbGN1bGF0ZSkgaG93IGJpZyB0aGUgbWF4
IElPIHNpemUuDQo+IFRoZSBsb2cgZGF0YSBzdHJ1Y3R1cmUgb2YgWEZTIGlzIHJlZHVjaW5nIHRo
ZSBjYXBhY2l0eS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBz
dXNlLmRlPg0KPiAtLS0NCj4gICANCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743CC6A6A02
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCAJrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjCAJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:47:05 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365513A86C;
        Wed,  1 Mar 2023 01:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677664022; x=1709200022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Y0Zig3LMdH//C0FcKsW8P2EojyXuzgJN8eWRnV74EF8=;
  b=NrVrrtpZjiY0Wuz/y5fiIqL+8E42y9Zaax1Hoy0/FC8ZY7vRu4BCVf2c
   BHOQJNh0ajLSx0gScSURCtOyzJ6cIXOGkjbGz6wjUVMCXkVKL0GkgHfhi
   JyxPvoZYDdrrQUTAAfP8J1V5haM7pOdapVYlg5qjESxA0f8Qq/nYamA3+
   2tNsUucc+VLhlYlVjurnvPXsWgy/+QrwghVpy2fuHkk0FRSJj/Oberxev
   uTEAx104flG1AU6kvAlqhZWtVGqweInpjlBg3Hy67Za7nFxMsz6nLQgwd
   qfrQ2WK5oL9UuNVd+y5GJ1fLxlAY1T0bTMa0TxIYR9ajjJTYJ1hjRP/QV
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673884800"; 
   d="scan'208";a="224297270"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2023 17:47:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q51mGryl9zHjsSXVhoClrimvL4pECMhw9VZMYmC9dMTuBBvhQ++bD0Q3pW1Rb5tQ/0IaC36MIyc/uXqoWPW1kibd2VovAhqWfAWlKo0HrQVLSzbj5jls9sL7s2szn8Dhw2kjotVQWNxPLxwj7wjyOfkkjZng02uDtz+yWULTYdQwslVd2CkxUcNhABiakv9i+OY7Id0pYt3sksWwADbEXm0sEqgk1lJz45iukeZnyQvWtXJ2w1M56QRIVLjLBSSPqBFDngwhflckKvi6VsT/R5yOUBzNG8IEypkFTAuavHzDDy0u3/uVrxW7GF4oO4g9oX4rb09uNGPoCqXYlOjtDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0Zig3LMdH//C0FcKsW8P2EojyXuzgJN8eWRnV74EF8=;
 b=EjK8WZ7QZNG+Czazm/xj6mwLkeTXt8Z9o1GpysFptXy95qJpcV/91OO6FtjjXqoFVItwVCeDBd64nB0it6z9PnktkSn2lXMFPmCvvNkJc0kp2N1lxmq9mtME8GhJoZZN7a6xI27VCaton+C6hx1bARA1h+KSYw2V/Aw51FLaOF2d70Z+2GhAEYWItBO8wh0Y3Jf45VKWsADdFXj+yxyk8OBPzNqcDdMQ7pseZYQzxguyCPH29wYnVni89JBbD+NgjVynXi6T/UREQyyvndkHbdk5bWX1wbBAGJdTTLUpduCyOiK1eoOMIqSe2CY0UO0nFpAgj9phPyjXLISVxAOSSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0Zig3LMdH//C0FcKsW8P2EojyXuzgJN8eWRnV74EF8=;
 b=xJ4IH+7VHAd9ztHZLccaPj/BC+8oRP3pAzyhJgH/UcFbkxMpd0JuGOPvcjS1yWe5nj+mSzPZRBXyrE5afgZQrCwK42IAWPVP+kBFSadyJejmwRxpnBlIO4mxXrM2lyfS1JXljY4Nh1pDRf3PmKpx8fjoPqITZpje7RuJhI88KgY=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by BL3PR04MB8057.namprd04.prod.outlook.com (2603:10b6:208:348::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 09:46:59 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::d4d7:5772:65c9:e4d1%2]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 09:46:59 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Topic: [PATCH 1/2] include: uapi: scsi: Change utp_upiu_query struct
Thread-Index: AQHZRtAnEVxdCbOh6UqEvS4KnyORTa7bFjkAgAfhZ3CAABSDgIACqcwQ
Date:   Wed, 1 Mar 2023 09:46:59 +0000
Message-ID: <BY5PR04MB632701F87296BEE554D3F055EDAD9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1677078770-30994-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1677078770-30994-2-git-send-email-Arthur.Simchaev@wdc.com>
 <b1f0ed44-d707-5593-7449-8a6bd23c9902@acm.org>
 <BY5PR04MB632717453EB0D403388B4F1EEDAF9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <21f73bfd-1d91-106f-d3a8-eb4674c517e6@acm.org>
In-Reply-To: <21f73bfd-1d91-106f-d3a8-eb4674c517e6@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|BL3PR04MB8057:EE_
x-ms-office365-filtering-correlation-id: 2bc8a625-8fcd-4cd9-0445-08db1a39e6e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: niCvXDGuepeHH11somNHFAD7bjNGPOIV2UMX4zShig3Z5SkdqUR2IHs6MqGKO2ne0zM9mZjJHCkfF53dztwXCTYzwdaXNaIf8YCXja1NbCGcdp5SxWBMAHhFw+ezhM15+ozjR7rfVyeGFln+jnjbBOr88hgKUKjL55FKvn6ZhrHpdu3AxX341lX6KMnBuBO7/m1e7uSNvIMNFGLb+WJH80vVkY7D9ZBZdtQnGNUejRNdlZIu6oe8jkij0Y6HvWPJSPeH5S8s0ytINld+1+CDgsm2vTBrpygzwP6JM0BmJcMH92/gOjfgRTU2lgnk6p+IxIH6QMYlgVH7f//3N2Codzx9aflO6IK5XndsoECwzB8cT0/YGT1DyW0MkVonjPaL8Exo1vdrPOVnBeVexE55+kLiSIkmjxRc8NuLUtiggscJxIYZqTaAMHnsL1qvtA4yYvd3htJgMZdd8cHUyRr1+bkMpNBfmvinR+FhFoYf3E8ZMCpVSn6MWJW47y2jtMpjqVenkh1HOKIbB5ZibApUDjU5BXPDOqauzvyVCvebZaZHmwMz/57d9kcEeicL0X/FGp8y0zlhthH1B+dzywYcVv4yd3sZT5JyfLlaZjyKY0tA9F324r0U7SHjoJHs0/CEBTXH7C99vwUAGyyS60McjoKbuqEyFJq6nYOxPxs5k2U0lsgoV44RjhqXdZUPKr76IBnxGkxijSJHTpx/uN//Lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199018)(38070700005)(52536014)(86362001)(64756008)(66476007)(55016003)(41300700001)(5660300002)(66556008)(66946007)(8936002)(66446008)(4326008)(2906002)(82960400001)(122000001)(38100700002)(8676002)(7696005)(71200400001)(478600001)(316002)(54906003)(33656002)(83380400001)(76116006)(110136005)(26005)(6506007)(9686003)(186003)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1lhdmZMOUFGTkpjWkhrTktmY2JrNnVJNXk2dDVyemYrQUovc1pwUVVybFlo?=
 =?utf-8?B?Ui9kNUNVU3dUd2NobG5xOXUvNkFFZTA2ZzZONkhoQi91d2wzR01hZGRoWDJo?=
 =?utf-8?B?LzJueHJKU2ZTOUV6QXMrN2JmdlhCcnlnd1hCVmlKaHRFVXRaZUJ5cnpPdXhQ?=
 =?utf-8?B?S0N2YS9zbWJUUjJGTGhjUDRadlFYZmx0eGc4L3NJUDhPV1VuTGNBTjQ5Sm5I?=
 =?utf-8?B?OVhZRUl0NnJQY0ZPV3ZoNVMwOVNiMXFhRWh6MlNBUGlCMEd5dFNiTldIcjgv?=
 =?utf-8?B?eEhsRyszenFYaCtCdjU2TzYvYVVJV0lYS25MOXJsaDE1WWZkNlRYcUZicmhJ?=
 =?utf-8?B?dTRlZ1g2aHcyL0F6cnF5REJ0YmZQOUNKbUswZ0tOMUZidXFaMXY2bkY5bytR?=
 =?utf-8?B?VUQ5NWlaazFHYVQ3Ny9GWFdXUm9NYldYc280MHpWS0QvS0FBaXRBUEdoT005?=
 =?utf-8?B?alcwRkxHVUQvbjlYazVUS3BxV1RzNTAxZGIyOTZJc0Q0SkxYTS9RamRqQ1lj?=
 =?utf-8?B?SE4zUEU5WDE1K0NCNk5KZWtNNWlKbXhpNzM0YUVZRnZkRXowbEQrN0IrNUhR?=
 =?utf-8?B?ZDkvdXIwZnk2c2ZTeXF3cWg0OFFUb3hVeWZwaVlDSStyY2M0L2RwZGFpaWZI?=
 =?utf-8?B?bFQxblJEV1orUlZnaHdKT1lIMHBnOHNWTys5RFdUVTgraTlPWTA5elVyejlG?=
 =?utf-8?B?Z0Y1TVAxVGxkQ1RSUjN0NTU0c1FFcCtwMmNsc2Y5RmtWTk9RWi83ckxLbVI4?=
 =?utf-8?B?UmhJbzlaZW5pWmNQVm55STFmK1g5amJrSGVZM3BNNUJHOWJheTdlTU1NTTlZ?=
 =?utf-8?B?ZVZ3Z0NSNmdQWkxlQkR1a2lkRWprRFBtbWF1WndrTGNKOXZocVJMSys1WjRX?=
 =?utf-8?B?RzI1TTFsNHpYWi9ma1Q3empBU2tLUUZ6N0tRY0tPa0owUXU2cjNLRERLTjNI?=
 =?utf-8?B?M0cwWGkxYURPUitJR2M0Wk91QlNUWUtybUhDTEtnek8vbUhiNGpLM1JycW9K?=
 =?utf-8?B?SkxMdUlKR0lKbnAzRDZ0MldpYlhRWThuZ0J2QVFUYkxPT05nOVMzWkhqVnZm?=
 =?utf-8?B?OVlPSHk5Yk5xaDFBcHl2RFNzT3hWZU8zQWV6NXhwQ2pOZkxMeklvTmtzeEVu?=
 =?utf-8?B?dGZ6anZnVE1uVUxqS0s1S281aDROczZsRVpwbkxaSnRJNkpDU1pjaEF6KzNY?=
 =?utf-8?B?c1AzYlV2WE50bGtLSnMzckhuN29RdlhWTHlsZlI5OERDL0ozaEFTYndwbHZU?=
 =?utf-8?B?M3pSQUFUR1JvRTMrTGp1ZGZOamR5RitRRVRBZlV1cFg2NlVLRG5GRitZRlR0?=
 =?utf-8?B?cVBtZ3VJWXB6WFRaOUk1UnVnenJOZ29QMFdaVWhtcmZIQ3pjRm5xa3hQeHhS?=
 =?utf-8?B?RVVIMkpBL1R6c2UxWVpGTmJyQnBxQW8xc1I0bTdIdXgyMHRySjhxNy8yajha?=
 =?utf-8?B?VVJHYjV0MzF3bFlTa1JPV2tHcGd6ZXFocDYvcFdpV0dmWVkzRzVrZ1hEM0U3?=
 =?utf-8?B?czdrUExQZGlibjdqM3g3VVFid2xXZEo3MEZjR3VOZmpWQVNPam1mMm41Q0Rp?=
 =?utf-8?B?Ri9rdUJhUlI2SFJHUGozMXhma3RheHBxWGpPbFhNOHZHeTdEYW04dWlDVTdB?=
 =?utf-8?B?MTE0MzdFWjBNZkk0eC9ENGZ0K3FHQ3d3dE5tdnJockZTeW81TDh0T251UVQ0?=
 =?utf-8?B?VVpkVEJZdHlkYm9rb2NxZSsrbHJzZlJqTjJZOWhvMmd4NHo5VGw1L1hnWktp?=
 =?utf-8?B?OG5QaHltZHpjWVBLc0RpaVpVeUdma2dFTSs5di9zbHcwSFdLVUlwUDQzeE4w?=
 =?utf-8?B?UjFzMmxXbUQrZGZXeno1cTljWFFQRDJqN3JxQ1cyOGdMSWttSkwwQU00b09h?=
 =?utf-8?B?Tnk0N3lvOFhqMlNqVkx0eHdZK1RzZVR3b3VyVExtSnY1KzNVWmtaYUltT1B2?=
 =?utf-8?B?MXZLYXpwcWpGbGUrOHZHUnF4dVBNblU4QjNQKzcxRzlaSUE5bW1DMWFGM1hX?=
 =?utf-8?B?dWRDVytCQkZTaG1CdVhFR3lZRGFqaktiQndWcW41bFM2SjZGSmpQSjNCZmhw?=
 =?utf-8?B?OVZlVnFMR21qbmN3RVBwd1VRSGZaYnM3UDM3bjVSQnIySjdSTTlEa2dqVTh1?=
 =?utf-8?Q?6bS/2oyXike8nPG0NSAmhNyfb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EPDQ2j0Uqi1Nbh4Ye5Cef08ZEGihYtaWoELuekHIz0ycgcJtRvvi2E4sdqzdrV96cznC1awp9srju6PeCdCVJXYp1Uz4KssS+SJneqVo6IztSKm2TXDJH3HpZQSp43AWHWvl/rXzrrCJEIgvZtYba2mKoX2DLi9btYscp4uLkdiUodYdJOPP0lk2ydmUP/6Lm4NggH0Qdlt68vaBmprZyfJudR4GncBe1rJ1pqCB8tm1WqgMOuurJhogr00JDw++KRwvW5wn6SmGnzVpZcn5rt9GZLFzXRaojIf2LAHBt9h8KFusfiLarpfdidnPy/Xs5oYygMq+J0SwSeEsq3oty5QNgYr1CbzMfxvvM8DnlD5uLbJ/64Nj6N+YjgEP/ssjr3PC9Jpb7BZ36zunfEFdUKRxW30vCX0w5C3actD5FCKIlBsAqYWUpuZVDijt3hNoRMMaFJNAINX8ajsyx2rc73xkgFvTKgUmGjOGLzbBRtOFJNpyeipudLfV2RvZx+QlodwDC2DYOGcSmLu/fWv0OuQS9f+iqMeD2doh0bLTMdqTPMlK40rUKD1OLAXrPhzijwtVPV9E/LztqmusD17eX62Oe+/gedJh4YfgfOJzZWl57TK0j12z3TYRUq0J0ghe4US0rzktdfHwX+C4C30reIPozzLFvEHNZ7g64NwIV6qAhlpukhWHvor6WwHMfWcIrAT3CAYL6m/+A6lisFYENZ6S8+W/VoSIMY4WVGhL8MkTWqGJBXGzoGzA9xXrgFjvQCdn52SxEkaS5zPpFRYqfcGc8YNqRDihaLLB3t4I0tleKwetsNVc+GbXFmZ2ap3Ac2kxX5gbt3Cp9MV3swttUjT8VWwJW4L9JrzCaiau50w=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc8a625-8fcd-4cd9-0445-08db1a39e6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 09:46:59.1930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLyasP0LCgkPg72XTI6pjYzAeG1cfF09iGYbj5yFhHu6iNFQwU46foYIZtPgbP6Mg2e0H38AZa2gCp0HQSbfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8057
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4gICBzdHJ1Y3QgdXRwX3VwaXVfcXVlcnkgew0KPiA+Pj4gICAgIF9fdTggb3Bjb2RlOw0K
PiA+Pj4gICAgIF9fdTggaWRuOw0KPiA+Pj4gICAgIF9fdTggaW5kZXg7DQo+ID4+PiAgICAgX191
OCBzZWxlY3RvcjsNCj4gPj4+IC0gICBfX2JlMTYgcmVzZXJ2ZWRfb3NmOw0KPiA+Pj4gLSAgIF9f
YmUxNiBsZW5ndGg7DQo+ID4+PiAtICAgX19iZTMyIHZhbHVlOw0KPiA+Pj4gLSAgIF9fYmUzMiBy
ZXNlcnZlZFsyXTsNCj4gPj4+ICsgICBfX3U4IG9zZjM7DQo+ID4+PiArICAgX191OCBvc2Y0Ow0K
PiA+Pj4gKyAgIF9fYmUxNiBvc2Y1Ow0KPiA+Pj4gKyAgIF9fYmUzMiBvc2Y2Ow0KPiA+Pj4gKyAg
IF9fYmUzMiBvc2Y3Ow0KPiA+Pj4gICB9Ow0KPiA+PiBBbGwgY2hhbmdlcyBpbiBVQVBJIGhlYWRl
cnMgbXVzdCBiZSBiYWNrd2FyZHMgY29tcGF0aWJsZS4gVGhlIGFib3ZlDQo+IGRvZXNuJ3QgbG9v
ayBsaWtlIGEgYmFja3dhcmRzIGNvbXBhdGlibGUgY2hhbmdlIHRvIG1lLg0KPiA+DQo+ID4gVGhp
cyBBUEkgd2FzIG9yaWdpbmFsbHkgaW52ZW50ZWQgdG8gc3VwcG9ydCB1ZnMtYnNnLg0KPiA+IEFG
QUlLLCB1ZnMtdXRpbHMgaXMgdGhlIG9ubHkgYXBwIHRoYXQgbWFrZXMgdXNlIG9mIHRoaXMgQVBJ
LA0KPiA+IGFuZCBpdCBkb2Vzbid0IGRpZyBpbnRvIHN0cnVjdCB1dHBfdXBpdV9xdWVyeSBpbm5l
ciBmaWVsZHMuDQo+IA0KPiBUaGF0IGRvZXMgbm90IG1hdGNoIHdoYXQgSSBzZWUuIEkgc2VlIHRo
YXQgY29kZSBpbiB1ZnMtdXRpbHMgYWNjZXNzZXMNCj4gdGhlICdsZW5ndGgnIGFuZCAndmFsdWUn
IG1lbWJlcnMgb2YgdGhlIGFib3ZlIGRhdGEgc3RydWN0dXJlLg0KPiANCj4gUGxlYXNlIGZvbGxv
dyB0aGUgcnVsZXMgZm9yIFVBUEkgaGVhZGVyIGZpbGVzLg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
QmFydC4NCg0KWW91IGFyZSByaWdodCAsIG15IGZhdWx0Lg0KQW55d2F5LCBJdCBqdXN0IHJldHVy
biByZXNlcnZlZCBmaWVsZCB0byB0aGUgc3RydWN0Lg0KQWxzbyBJIGNhbiB1cGRhdGUgdGhlIHRv
b2wgYWNjb3JkaW5nbHkuIEluc3RlYWQgbGVuZ3RoIGFuZCB2YWx1ZSBmaWVsZHMsDQp1c2luZyBv
c2Y1IGFuZCBvc2Y2Lg0KSW4gdGhpcyBjYXNlIHdlIHdpbGwga2VlcCBpdCBiYWNrd2FyZCBjb21w
YXRpYmxlLg0KSXMgaXQgT0s/DQoNClJlZ2FyZHMNCkFydGh1cg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3Jn
Pg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI3LCAyMDIzIDc6MDAgUE0NCj4gVG86IEFydGh1
ciBTaW1jaGFldiA8QXJ0aHVyLlNpbWNoYWV2QHdkYy5jb20+Ow0KPiBtYXJ0aW4ucGV0ZXJzZW5A
b3JhY2xlLmNvbQ0KPiBDYzogYmVhbmh1b0BtaWNyb24uY29tOyBsaW51eC1zY3NpQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIGluY2x1ZGU6IHVhcGk6IHNjc2k6IENoYW5nZSB1dHBfdXBpdV9xdWVyeSBz
dHJ1Y3QNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgV2VzdGVybiBEaWdpdGFsLiBEbyBub3QgY2xpY2sNCj4gb24gbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoYXQNCj4g
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiAyLzI3LzIzIDA4OjAzLCBBcnRodXIg
U2ltY2hhZXYgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gICAgKi8NCj4gPj4+ICAgc3RydWN0IHV0cF91
cGl1X3F1ZXJ5IHsNCj4gPj4+ICAgICBfX3U4IG9wY29kZTsNCj4gPj4+ICAgICBfX3U4IGlkbjsN
Cj4gPj4+ICAgICBfX3U4IGluZGV4Ow0KPiA+Pj4gICAgIF9fdTggc2VsZWN0b3I7DQo+ID4+PiAt
ICAgX19iZTE2IHJlc2VydmVkX29zZjsNCj4gPj4+IC0gICBfX2JlMTYgbGVuZ3RoOw0KPiA+Pj4g
LSAgIF9fYmUzMiB2YWx1ZTsNCj4gPj4+IC0gICBfX2JlMzIgcmVzZXJ2ZWRbMl07DQo+ID4+PiAr
ICAgX191OCBvc2YzOw0KPiA+Pj4gKyAgIF9fdTggb3NmNDsNCj4gPj4+ICsgICBfX2JlMTYgb3Nm
NTsNCj4gPj4+ICsgICBfX2JlMzIgb3NmNjsNCj4gPj4+ICsgICBfX2JlMzIgb3NmNzsNCj4gPj4+
ICAgfTsNCj4gPj4gQWxsIGNoYW5nZXMgaW4gVUFQSSBoZWFkZXJzIG11c3QgYmUgYmFja3dhcmRz
IGNvbXBhdGlibGUuIFRoZSBhYm92ZQ0KPiBkb2Vzbid0IGxvb2sgbGlrZSBhIGJhY2t3YXJkcyBj
b21wYXRpYmxlIGNoYW5nZSB0byBtZS4NCj4gPg0KPiA+IFRoaXMgQVBJIHdhcyBvcmlnaW5hbGx5
IGludmVudGVkIHRvIHN1cHBvcnQgdWZzLWJzZy4NCj4gPiBBRkFJSywgdWZzLXV0aWxzIGlzIHRo
ZSBvbmx5IGFwcCB0aGF0IG1ha2VzIHVzZSBvZiB0aGlzIEFQSSwNCj4gPiBhbmQgaXQgZG9lc24n
dCBkaWcgaW50byBzdHJ1Y3QgdXRwX3VwaXVfcXVlcnkgaW5uZXIgZmllbGRzLg0KPiANCj4gVGhh
dCBkb2VzIG5vdCBtYXRjaCB3aGF0IEkgc2VlLiBJIHNlZSB0aGF0IGNvZGUgaW4gdWZzLXV0aWxz
IGFjY2Vzc2VzDQo+IHRoZSAnbGVuZ3RoJyBhbmQgJ3ZhbHVlJyBtZW1iZXJzIG9mIHRoZSBhYm92
ZSBkYXRhIHN0cnVjdHVyZS4NCj4gDQo+IFBsZWFzZSBmb2xsb3cgdGhlIHJ1bGVzIGZvciBVQVBJ
IGhlYWRlciBmaWxlcy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEJhcnQuDQo=

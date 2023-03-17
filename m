Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D927E6BEF93
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCQRXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjCQRXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:23:30 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678ED35ED4;
        Fri, 17 Mar 2023 10:23:28 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HGkpf1008037;
        Fri, 17 Mar 2023 13:22:32 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pc6yn6xxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 13:22:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ha2sWPS+ryGT2gBt2XSlEMCVXNHs7FjFlXlCSYMaoRUfY6UdOoRdUgj9N/WaVJTEX97TGdwaUFpjxAmbRUuvP3dQ1sSKSMOau8NtZFzscdXzf5jzCkJPB9SzXSwNzxm8N1luKGy896Kpq479wHi09We7m9tMUwUvbOWxN4sic12tWMJ696trp//QTd/dAnWOH+qaT0WUTIfNRf00VgMvbwkJahaTyW0KnhHMPIVPamxKDj1EXu4cD+/eumo3RAn6GCXuEs140tf/NSdnOa2xzgI3Er4nhLKKjVs4yODA7amOjmOvSCSN5lCXS3wABqOC00ri+ZTdlESKpTAlhY+TyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nvm55QWkoIA08EVC8/aYmg7lHAzReLUi8bY/GSf+B5g=;
 b=d2ObDFGgb8W9hNiNaFFAz2ACWQYyyY4JF53BQZ0AUXc3sK5w7Id28W6hheEqAyjVYcl5X2vLQ4eM6S1wnN7TE6eQvKZ9zq6ajhR3craR/2kWIKuWo7nz6stvWzLqJnsdqFRVX4VG9keJhfJwrXfJ9qaU4lEnpv0r64Lwp7Sv0ZVr7YCLnw79okW5CZPOvO74DgypUkK+DUCVwVNMKUzA7PxRUelEyt/lREmU2FvYK6WPoP29mDZHDxKXIP3PdX48tYCBLy9KwA9gUjrwujprdTKSbPIEZhfvmGknF48UJDXpnKAFUxPg5iUtvbHjatbmiPVrEWqQAUlqXzTGfgd8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nvm55QWkoIA08EVC8/aYmg7lHAzReLUi8bY/GSf+B5g=;
 b=SQRmahtD6pr/Qe/bParO472az3B8/r2vWiA/cK4p1tfwKBiI4efwev5cWCJ18GH0t/h1OoGiMJxwZ3yEdUVMwYN84LEeWP17AG3dcFTarUKgU5wltOu4EMxND72RcSmOUhk8tBwt4onmxWBjr+TIbPQeXO3AyEFxYAL5I+55aAU=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by MW4PR03MB6489.namprd03.prod.outlook.com (2603:10b6:303:120::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Fri, 17 Mar
 2023 17:22:28 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::546:72be:4164:dde7%7]) with mapi id 15.20.6178.033; Fri, 17 Mar 2023
 17:22:28 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?4oCcUnlhbg==?= <ryan.lee.analog@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>,
        "wangweidong.a@awinic.com" <wangweidong.a@awinic.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "ajye_huang@compal.corp-partner.google.com" 
        <ajye_huang@compal.corp-partner.google.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
Thread-Topic: [PATCH V2 2/2] ASoC: dt-bindings: max98363: add soundwire
 amplifier
Thread-Index: AQHZU7bU4PyhIooW70WRbfXcEM0/va71Sy0AgAnyNvA=
Date:   Fri, 17 Mar 2023 17:22:28 +0000
Message-ID: <SJ0PR03MB6681C6888CACE552BC9F2C268ABD9@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20230311011409.210014-1-ryan.lee.analog@gmail.com>
 <20230311011409.210014-2-ryan.lee.analog@gmail.com>
 <de5d336e-43c4-9016-134c-bf5a0aa18280@linaro.org>
In-Reply-To: <de5d336e-43c4-9016-134c-bf5a0aa18280@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY214bFpURXpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RORGt4TW1ReE5qSXRZelJsT0MweE1XVmtMV0poWWpNdE56QXhZV0k0?=
 =?utf-8?B?TURkbFpHSTVYR0Z0WlMxMFpYTjBYRFE1TVRKa01UWXpMV00wWlRndE1URmxa?=
 =?utf-8?B?QzFpWVdJekxUY3dNV0ZpT0RBM1pXUmlPV0p2WkhrdWRIaDBJaUJ6ZWowaU5E?=
 =?utf-8?B?RXlOaUlnZEQwaU1UTXpNak0xTkRjek5EWTNPRFEwT1RNeUlpQm9QU0kwVlVG?=
 =?utf-8?B?cGFXbFdlSE51UkVNelZsSnBiV3RTT0ZsMmRuRnJWemc5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUpGUzFsblREbFdhbHBCVW5aNk1uTlRSM2QyVFZkSEwx?=
 =?utf-8?B?QmhlRWxpUXpoNFdVUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZGa2FXczFVVUZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6681:EE_|MW4PR03MB6489:EE_
x-ms-office365-filtering-correlation-id: cfd97e7c-3683-41df-e685-08db270c2eda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1sDM+FwYxkMW8Jnx61NztjRrNnbQeZr/AJgy+feaZcBA7HAjHjujjn/l7y0p/YeN1fLuu89aV6ZMmJJ8pbEX6xPtoiBQ69X/qhBUK7FRLVUn5J6BYZyzsaP3HhaYc0WnVJqkI0YYnM0XZSGN3LkwS1SxNYlZE3dGMYSynWH1SlMtQy0Zoby1rreIkExcAq3JXabwrd+KocCHfKCrA600AvR+Rg97F/bWL7LpKRBxXOPaPc8NySX356nSrEDOSdcPlUmfWInLUU6khl96BmnnkzqDXPxpwlPmDHgR0ZOfUdiq/jryz443giqNULbRuyxU9re0uNSJVLKuXkrODY57KxuwlJCthQ3yoKG//QUq2vTD0YQHxl2v3KzsiEx/itfwJrKPHISGtD2uEhmeUu2ZCDx6laQ0Yy+AcI5HiubOEg9tCRJGRJvMwvfMxc4k+vVSsVW9Gee+Bbxqn4Zd4dW3Jt65dyTaHOQRGMdGQElf217Lfv0Klnsip4GUo+IWRp1I0NHFrS+lkHRgdIsvL2R5jFoExQQjQJgVH2eNxin1W3iT5UbnXHg45a6AQGhvMlrWCx6CZQjZGYQ4QqI3+4k9Ffl26ooy0t9Ha31swtJGz3j/H4TMAm5Uts50kTuMF46HjWTXqXz+Zrjr6O82GVJbJ3zpxWuZYkLPUzdSN5O7+0H5tnr7cs4sGiNHzWZcHx/GsCC2RVApGxLiX9G/EOrLOf7/GbpRVq2+QD4ZN/wMJo5LOcd2i44iLK/bKGv76eM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199018)(66556008)(76116006)(7416002)(2906002)(8936002)(38070700005)(38100700002)(921005)(86362001)(122000001)(71200400001)(64756008)(5660300002)(478600001)(52536014)(66946007)(66476007)(66446008)(8676002)(41300700001)(6506007)(7696005)(55016003)(110136005)(9686003)(316002)(83380400001)(186003)(53546011)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXdIYlRPOHVrUjZaUWRudldacVhkWTA2UnZpTTVnNXJJL0xqaDdnWkhXNW1D?=
 =?utf-8?B?amRFVXNVL2NFY3RBMTZGMytwVFg2SWlqMTdQRllXMDlzLy9QWlE4eCtEd2Fm?=
 =?utf-8?B?VWlIVlZuNExaMHhnbndzeFdYcm5tVXNweWg2ckFQbHlaNi9FcUdSdUphUmt6?=
 =?utf-8?B?U0VqOVFkbTN1REd2U04zcTQ4TTdReGRzWURFR21rNm5vN1VoL0xPOXNCNXps?=
 =?utf-8?B?RXhvZ0tkY3cxMGNMcXQ3N1Z5ejFOV0VJTjBkc1VRMGkvNmdCK1lOUHROdHZv?=
 =?utf-8?B?cXVkN0Z2NXVnb3pDNTlmcGtBemxQWUU0ZzFZRXhkRDVuT2hwYWdXeFY5bUtQ?=
 =?utf-8?B?ajQrNzFhZnhDMG04Y29JRThIMFNhUUdYWkVxY1dMc2l5NFBRTk1XalJXVmRo?=
 =?utf-8?B?bUtZOUxhK1F3KzQ1UUZMdDdDQXptTkVUSyt5VTJXZUtPaHpsN3ZQQTgrdkxs?=
 =?utf-8?B?WWdPSFVqTDY4NWNMeHUvL3NVbnhUdWR2a0hZN3RPalNZMU9GKzhjdmRDNVgy?=
 =?utf-8?B?NFJEMzlpbXQ4TE9Hd1BkVS9BY1EvUk13YXBwUUZiWWgzZU5hdkg2dzUwV1Jk?=
 =?utf-8?B?RjNzTFNLUlBuOFZHYlZVTXhTR3dTL2Nta09OSEhhdjcvRHpEcnNnTmRnSUlW?=
 =?utf-8?B?dGFXbDNUQXQwa29IWkZiM1YvTC81NmhXQ2VGMC9VRlV0THJEbzlPeXJQeGlr?=
 =?utf-8?B?V0NpWkVaVURFd1JCN3o3c1NYVEJaZGdDR1RodmdSeUhyeDEyVjNqWWFSQ3Jw?=
 =?utf-8?B?RUxOLytNdEhML2taZkxRV0xhdkI0TGZGOU11cWEzZ0hBS09wZjE4THVkV09H?=
 =?utf-8?B?UkUwNWh0RFlSZWFpVlVsQXE1ajVJUm5USXk2OXRFSlJyOU4zUmljZi95NW03?=
 =?utf-8?B?dHdFVjhFdnkxNWJNeDdPc0dIV3pvMzVNRnJwWEdycUN0bkhXTW1DeGFWVUpy?=
 =?utf-8?B?MnNNemhYOVFYUm9kS2pWTE5tWFVzT2lRQ3Z5UlJ2c3IvdEt5b0tYU3hKdXdT?=
 =?utf-8?B?OUxNcmRFVlNCUkF5SW1WaDFFN29SYTJaOWxoeW9oOTRKd0VneWNET0lITWha?=
 =?utf-8?B?ekxUSUI2N2JWNDhtVkFtRjJDTGg2cFZxYmovV2dHeUNXR05LcWtPWDVuRmRu?=
 =?utf-8?B?WHpqYnNiS2Z5My9tSVVZam5UNXV5QjhXZ2JQdUxZQ01BR2loM2NvaTlCWmEx?=
 =?utf-8?B?eVAyZmtWV3kvYUlidlRoTnJzMFdVZkRPL2NJU24yeTFNOVkvL25HYlJSaGRK?=
 =?utf-8?B?eGJHamJLZWlqSVVDbHA5SkxaM25qWUUxSURvb2V4NHFjWG1iS3VyQ0tVQll0?=
 =?utf-8?B?ME5CYUJWQ3dnWDNOQ09uZzVyY0hIVG1TbFN0MTdjNWJhbU14bHllM3Ric2JU?=
 =?utf-8?B?RXlDdzVxcW4xOGQ0dnMzVHgzeFJjQU1PbldKSDlISFQ2enQ1RFQ3ZEhGTitm?=
 =?utf-8?B?Z2c4Vndqa0RrQWcwZDJHSFlHNTUzb3BUT3RVSXZkYm1QazV3VEd2NXhTcXhh?=
 =?utf-8?B?Z0dtdGRXYUQrSzdBWWNvcktMRG5BVzVsTXhxaHFmY1ZDeEd4SlBoaWZwQWZi?=
 =?utf-8?B?d3l1VEZCQ0lvMjVLM2Zrc3ZPeDZCU2lBRnFBVmx0MWpuYXYwSFhJVVBBa1Ew?=
 =?utf-8?B?SG56RmhhUGNUa3Q5SENrZVczT0NTRXYvelZSUVZTb2ZWSm95QUZxdVJpamNN?=
 =?utf-8?B?S29oOE1NM2pJemx4Yi9waS9FdmlibnF0Y1FaSnJWdWdpdEJXVG0rVnQxQWFD?=
 =?utf-8?B?N0Jyb1dCSnVrL1BveGdOUTdjNHR3UVp2ZHNQaTcxeG84OTN3eXE5cERoRFJG?=
 =?utf-8?B?bUdsK1h1M1Q0MHpGTkd2NXVWanFSMGJnT2orSnN4UUVDNitBQTFraHpneGgy?=
 =?utf-8?B?OHNDUFIvc2JoZ2VMeDBLeE8vUlVwaUFlbk9hNHJEVStGbFQ1bEtDUmRaYmhU?=
 =?utf-8?B?RHozNWxLK2VrUExRNUN0VUUyWUlGaW14UW5iUlJCckJiRmRHcDRETHdZb3Bo?=
 =?utf-8?B?UG1Cc0k5aW1TOEpiNDQ1NzRwNVBxMytXMGQ2TnQ4Qm13ZGJUUWZhSy9td2dI?=
 =?utf-8?B?UE8rZDkvUTVteG5yKzRqd21FaXlGN3AzbDZOQ283Y1ZkQkFPeWJuamZJaEtS?=
 =?utf-8?Q?FfkPTnxgY2B403/iwZOBpLY24?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd97e7c-3683-41df-e685-08db270c2eda
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 17:22:28.1620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCdQsuEKnURwTCeBHnhzfJ1kilnIqcfq2/iou77igyp28onJ7shc6b+Ebjs4eW6FOsISrXFjek6HJF2+oGZ/7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6489
X-Proofpoint-ORIG-GUID: JY0pnfW_ElQyFWY29JqVE-HSjM3xxW67
X-Proofpoint-GUID: JY0pnfW_ElQyFWY29JqVE-HSjM3xxW67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_14,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=874 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170116
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXJj
aCAxMSwgMjAyMyAxOjEwIEFNDQo+IFRvOiDigJxSeWFuIDxyeWFuLmxlZS5hbmFsb2dAZ21haWwu
Y29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBwZXJleEBw
ZXJleC5jejsgdGl3YWlAc3VzZS5jb207DQo+IHJmQG9wZW5zb3VyY2UuY2lycnVzLmNvbTsgY2tl
ZXBheEBvcGVuc291cmNlLmNpcnJ1cy5jb207IHBpZXJyZS0NCj4gbG91aXMuYm9zc2FydEBsaW51
eC5pbnRlbC5jb207IGhlcnZlLmNvZGluYUBib290bGluLmNvbTsNCj4gd2FuZ3dlaWRvbmcuYUBh
d2luaWMuY29tOyBqYW1lcy5zY2h1bG1hbkBjaXJydXMuY29tOw0KPiBhanllX2h1YW5nQGNvbXBh
bC5jb3JwLXBhcnRuZXIuZ29vZ2xlLmNvbTsgc2h1bWluZ2ZAcmVhbHRlay5jb207DQo+IHBvdmlr
K2xpbkBjdXRlYml0Lm9yZzsgZmxhdG1heEBmbGF0bWF4LmNvbTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnOyByb2JoK2R0QGtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBMZWUsIFJ5YW5TIDxSeWFuUy5M
ZWVAYW5hbG9nLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWMiAyLzJdIEFTb0M6IGR0LWJp
bmRpbmdzOiBtYXg5ODM2MzogYWRkIHNvdW5kd2lyZQ0KPiBhbXBsaWZpZXINCj4gDQo+IFtFeHRl
cm5hbF0NCj4gDQo+IE9uIDExLzAzLzIwMjMgMDI6MTQsIOKAnFJ5YW4gd3JvdGU6DQo+ID4gRnJv
bTogUnlhbiBMZWUgPHJ5YW5zLmxlZUBhbmFsb2cuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBh
ZGRzIGR0LWJpbmRpbmdzIGluZm9ybWF0aW9uIGZvciBBbmFsb2cgRGV2aWNlcyBNQVg5ODM2Mw0K
PiA+IFNvdW5kV2lyZSBBbXBsaWZpZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIExl
ZSA8cnlhbnMubGVlQGFuYWxvZy5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmcm9tIHYxOg0K
PiA+ICAgRml4ZWQgYSBzeW50YXggZXJyb3IgZm9yIHRoZSAnZHRfYmluZGluZ19jaGVjaycgYnVp
bGQuDQo+ID4gICBSZW1vdmVkIHVubmVjZXNzYXJ5IHByb3BlcnRpZXMuDQo+ID4gICBBZGRlZCBk
ZXNjcmlwdGlvbiBhYm91dCBTb3VuZFdpcmUgZGV2aWNlIElEIG9mIE1BWDk4MzYzDQo+ID4NCj4g
PiAgLi4uL2JpbmRpbmdzL3NvdW5kL2FkaSxtYXg5ODM2My55YW1sICAgICAgICAgIHwgNDIgKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc291bmQvYWRpLG1heDk4MzYzLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvYWRpLG1heDk4MzYzLnlhbWwNCj4g
PiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9hZGksbWF4OTgzNjMu
eWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4w
ZTcxYjZjODQwMDcNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2FkaSxtYXg5ODM2My55YW1sDQo+ID4gQEAgLTAsMCAr
MSw0MiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkgJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo+ID4NCj4gK2h0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9z
b3VuZC9hZGksbQ0KPiA+DQo+ICtheDk4MzYzLnlhbWwqX187SXchIUEzTmk4Q1MweTJZITRld3l5
S0lOQkJ4MWFqMmVmT0FSVnBReEMzVHVOZUsNCj4gQ20tSzRPDQo+ID4gK1l2V0ZQZlFGQ3BiaHM2
TmVma0pVNXMwRy1oNjI1bnlqNUl0ak5lLU40VkgwMDItc1pBdWNZbyQNCj4gPiArJHNjaGVtYToN
Cj4gPiAraHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLQ0KPiBzY2hlbWFzL2NvcmUueQ0KPiA+ICthbWwqX187SXchIUEzTmk4Q1MweTJZITRld3l5
S0lOQkJ4MWFqMmVmT0FSVnBReEMzVHVOZUtDbS0NCj4gSzRPWXZXRlBmUUZDDQo+ID4gK3BiaHM2
TmVma0pVNXMwRy1oNjI1bnlqNUl0ak5lLU40VkgwMDItUG5oZWEzVSQNCj4gPiArDQo+ID4gK3Rp
dGxlOiBBbmFsb2cgRGV2aWNlcyBNQVg5ODM2MyBTb3VuZFdpcmUgQW1wbGlmaWVyDQo+ID4gKw0K
PiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFJ5YW4gTGVlIDxyeWFucy5sZWVAYW5hbG9nLmNv
bT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBNQVg5ODM2MyBpcyBhIFNv
dW5kV2lyZSBpbnB1dCBDbGFzcyBEIG1vbm8gYW1wbGlmaWVyIHRoYXQNCj4gPiArICBzdXBwb3J0
cyBNSVBJIFNvdW5kV2lyZSB2MS4yLWNvbXBhdGlibGUgZGlnaXRhbCBpbnRlcmZhY2UgZm9yDQo+
ID4gKyAgYXVkaW8gYW5kIGNvbnRyb2wgZGF0YS4NCj4gPiArICBTb3VuZFdpcmUgcGVyaXBoZXJh
bCBkZXZpY2UgSUQgb2YgTUFYOTgzNjMgaXMgMHgzWDAxOUY4MzYzMDANCj4gPiArICB3aGVyZSBY
IGlzIHRoZSBwZXJpcGhlcmFsIGRldmljZSB1bmlxdWUgSUQgZGVjb2RlZCBmcm9tIHBpbi4NCj4g
PiArICBJdCBzdXBwb3J0cyB1cCB0byAxMCBwZXJpcGhlcmFsIGRldmljZXMoMHgwIHRvIDB4OSku
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBl
bnVtOg0KPiA+ICsgICAgICAtIGFkaSxtYXg5ODM2Mw0KPiANCj4gQXJlbid0IHNvdW5kd2lyZSBk
ZXZpY2VzIHN1cHBvc2VkIHRvIHVzZSBkZXZpY2UgSUQgYXMgY29tcGF0aWJsZT8NCg0KWW91IGFy
ZSByaWdodC4gQUNQSSBkZXZpY2UgSUQgaXMgbm8gbG9uZ2VyIHZhbGlkLg0KSSBzaGFsbCBhZGQg
dGhlIHByb3BlciBTb3VuZFdpcmUgZGV2aWNlIElEIGZvciB0aGUgYW1wLg0KPiANCj4gTWlzc2lu
ZyBibGFuayBsaW5lDQo+IA0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogUGVyaXBoZXJhbC1kZXZpY2UgdW5pcXVlIElEIGRlY29kZWQgZnJv
bSBwaW4uDQo+ID4gKw0KPiANCj4gSXQncyBub3QgYSBEQUk/DQoNCkl0IGlzIERBSS4gSSBzdXBw
b3NlIEkgbmVlZCB0byBhZGQgI3NvdW5kLWRhaS1jZWxscycgaW5mby4gSSBzaGFsbCBhZGQgaXQu
DQoNCj4gDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVn
DQo+IA0KPiBNaXNzaW5nIGJsYW5rIGxpbmUNCg0KVGhhbmtzLiBJIHNoYWxsIGZpeCB0aGlzLg0K
PiANCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxl
czoNCj4gPiArICAtIHwNCj4gPiArICAgIHNvdW5kd2lyZSB7DQo+ID4gKyAgICAgICAgI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAg
ICAgICAgYW1wbGlmaWVyQDMgew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gImFkaSxt
YXg5ODM2MyI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwweDM+Ow0KPiANCj4gVGhhdCBsb29r
cyBhIGJpdCBkaWZmZXJlbnQgdGhhbiByZWd1bGFyIFNvdW5kV2lyZSBidXMuIEkgd291bGQgYXJn
dWUgdGhhdCBpdCdzDQo+IG5vdCBTb3VuZFdpcmUgYXQgYWxsLi4uDQoNClRoYW5rcyBmb3IgdGhl
IHJldmlldy4gTXkgYXBvbG9naWVzLiBZb3VyIHN0YXRlbWVudCBpcyBmYWlyLg0KSSBzaGFsbCBt
b2RpZnkgdGhlIGV4YW1wbGUuDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9
Ow0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

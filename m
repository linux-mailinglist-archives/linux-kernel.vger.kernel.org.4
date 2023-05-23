Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6019170E559
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbjEWT3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbjEWT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:28:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3A2126
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684870137; x=1716406137;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=XiiFVVAKIlrbgR+JOQyGpgGoDDq1nkS5P4aR6zuAcOg=;
  b=hTm7HxZhNXGKBP1vdBXQOslVieB/yhcHWFm+P90eY65dG1orAJCji72c
   naWb+6WS4G/kT2RwkZCTZL7tUm/mappOzOKvhEf+RDY8SPOourpiC8SR5
   DgRfpYHOiIelQo4wJB1pN5wXu/fytriKywUQ7R4+dOVpIbCqPRPug4sae
   Awd1w/LgSvbcgaJpfsUjjulpQoEKnUSc+BdLcMJfiMRp7kH3p/iqIpujL
   Ie5OrxSQaKxxnzMOauepy5yDyINwZW53iUIyvCQXC/9mto3cltU5FL/Yc
   NPE1+TpVZk58zsomjFriMLE63Mc58SDe+WiUyMt78UlFSibdS9ko+yaAO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="337924001"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="337924001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 12:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="848418283"
X-IronPort-AV: E=Sophos;i="6.00,187,1681196400"; 
   d="scan'208";a="848418283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2023 12:28:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 12:28:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 12:28:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 12:28:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 12:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEevA5vQhpK2HHhBzTxflrdEUeXS/woijTSqPbwjaCm64mYlQZ6sY8VyTumkJbHnBb52okUpQTrxmlYpruM6Vzc6fYA8hjXONLIk6ddKxP3KCqC6OCAu6K3/jVl5koKxxyUGINCvCxcI7p0SN9fQm7PQmdy1Q/1TALdPe/Y3YkWIUY1hlOSlVJ7yiEQa00rEYFCGmVEa5oA1xIUQ7Dy5Jmq/Eheb1qwImxmGKHP9TGflrL1wWzjb2hgiedMFh+QBaEo/88BOg9G2BbWf0a/zSnP6lLZjfbV6OZSBT8FahBfFfAV8phUWa8toPnRLbNKYx+tWZgsJvU3EM8rJJlRoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NDeuU0ogAELwTQzqWNOsJ3JvO5DAJ0abAaS7eF/VXI0=;
 b=RLin6MnsNyaufWyHe2UBC1e+wWw3CIjmloYBtACP2f8EyZjbvuB84NFtRK40RmejqBN9HQsAo5mhuQoEyDMYbxH0PYjYBiDGWlXOZg3xCp0SS4E0EE056kuX3pU/m4cDFP070OCbq1YrAzBaybMq7dOLKN62OrShL+U03HOVdYwcuz0YluUh9UHmAl2yykzj8FHfRHC9mE7kREgSIjQzByzkw843I8YoR8KERzjf/E9hOqAbI4mTaN++qG1UGecBiaQLdmvaQETFUJ/c4hF7clL36Vb4ogOwLESwJKDIou2nXCfUrRxbcmxi4YhO3PAPjCNW/NiYogg2cZFy44f5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6523.namprd11.prod.outlook.com (2603:10b6:510:211::10)
 by PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 19:28:52 +0000
Received: from PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::3038:74a:aa16:8225]) by PH7PR11MB6523.namprd11.prod.outlook.com
 ([fe80::3038:74a:aa16:8225%5]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 19:28:52 +0000
From:   "Preble, Adam C" <adam.c.preble@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: How do I force an IBT trap in a demo kernel module?
Thread-Topic: How do I force an IBT trap in a demo kernel module?
Thread-Index: AdmNrJN/HBQNXQy0RfSVuasMlQAruQ==
Date:   Tue, 23 May 2023 19:28:52 +0000
Message-ID: <PH7PR11MB65237A81D8258BB1E10969A9A9409@PH7PR11MB6523.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6523:EE_|PH7PR11MB7643:EE_
x-ms-office365-filtering-correlation-id: 59f2e3d8-980b-4554-20fd-08db5bc3f11b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZBRvXynFWPmaAJLelJ+usOHr/ORw0n0ZjHDmUQxilyd7626ixlbaN0quH3SIlUAgFmpgLV9S+AKU1MHpLOCL20+de2rWNvRMNcXKnwXArJfvcjqnxjU6akhSfqtM6XjEbK+8tU8m1GTOiW/avdsVcYEKHB69kAi90Ock5kTLWXa7sA/FhrfLh0fYRTVVz2FDwqInFB+ducCdhY8wqJn2dP4CwXZcsLXfJKXqMQ0JiIIegktOk2vmK70b06TvVIS3Jak1u1yCE7mNQ2wjmvLVMl3dfTKJ7kbB9tYnVuPKPuDjQ51isU9nJKlIKc9w5hYK9Duvi6DWZ1dfGGle5JNL0GK2rpis62bxwifn4A2zVhxPfAVhkdkDYPeOfNoqHn0nptG33t+Em/oUk+jFSdB9+4rm/RKObT5FEVeuyBhjbGbWZS0o/pnTPySqGsti2iAnKYmZC4q1i9jVJOEIOJFp3tkdZFJMkRz3ELM/LwC4Hf1IG64hSLgDoIuLlJO3pT3oRTYzmCBiiIXAo1s4lTJaYd/5z1e+4PEgEcYRaSsyqieS9+X4Gx41ge4OYDsDBvOkuBcZ1TaOny6ZShdW1+vSSb4xddbCrgd0Wpn4UbOJeVAwgAjmu1ss0oo5Ppu3OPtM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(7696005)(41300700001)(478600001)(316002)(55016003)(66476007)(64756008)(66556008)(76116006)(6916009)(66446008)(66946007)(71200400001)(52536014)(5660300002)(38070700005)(86362001)(8936002)(8676002)(38100700002)(33656002)(82960400001)(6506007)(26005)(9686003)(186003)(122000001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DT7oFCzPzhxoJnCID1sm2l+JkNb/niAIuET/55gIaZLZE6fuzCk7mFMySA7t?=
 =?us-ascii?Q?3cVO/LCWUnRo509WSJSb5wZzCyw3iRdnpmH2CFgsylwhCMLJGQ3SRDrU86+3?=
 =?us-ascii?Q?+h9RkqXGMfrMeoiUMb2BeeljWqYwWmmMx3bTYQFFVsYOrdN3epfPtU9f1m2c?=
 =?us-ascii?Q?AdeJOs5JEJeXrGec06rRb5o2C4WygaxKGDt1xKJa66yg0/cL2OshbjLp2lGc?=
 =?us-ascii?Q?G49tmA2lOeyGqYdn4r1iVvk2HYRP3BVhqzyPMSZSLwRRPiGcHKk7yc+VdaOp?=
 =?us-ascii?Q?V3C7jnipDh3FjzcVFbGCBJ4VL+tpVK8XhyGca3EKmUuHaCVsjXauAFTkwoKz?=
 =?us-ascii?Q?6bsnDmx3+DJBdizQKoqWQ7Prcq0Po8m6wM4+H0W2l2sDcEGnQSPJYvxfV2GB?=
 =?us-ascii?Q?SivQRq1umvpsu0FvPc3q5VczRcIgjNhgrW6/CmIoax2PIJFyMipBGtd/vsbi?=
 =?us-ascii?Q?PZdSmDLOu3NiS4Rf266WwOJ+w2kAjxB6NWfZVNo9Fncqs7pTS6GpF0Gm+qnu?=
 =?us-ascii?Q?lMznozPwXvFrOKss9S/XMjYfY931g8fz/I8IkNWLyWt81sIJ94CMjz+qDO8d?=
 =?us-ascii?Q?VIM7jrnpwAmuphqiJBXmKU7P9qRxnaeCOZdDnb4QIJVOVJgEJVYY/lqUAQm8?=
 =?us-ascii?Q?ix5i+B793JCRQ7rViF9ItsH+Zzbc0+CR8vcInLbFPkRd1Mebt/cqcDNPJc9o?=
 =?us-ascii?Q?HbI7M9LbNYAUwuOTV83Nc7dURNghR35xbse7QXZZtNqqHc5vRg5XuQeYIR9X?=
 =?us-ascii?Q?ta8AQiSyGgXNTiGjUR2suGIoKYV7lr5NLwfdPmtALYLX2nlmo7hMUxrONu8L?=
 =?us-ascii?Q?TopwRDJOAmas9NCBMIQ+QE2YODwAYqgxW8xBXBXoUYuBMp3p8U8OZ0bH/I7I?=
 =?us-ascii?Q?G6MngbfOeyiq+tG3BRas1GrqLF/JL8AcoK9Epz+zUulR23ZITb39n166f+9u?=
 =?us-ascii?Q?dmmGVly0yW3jXXAzLfNe/7A5dWb3IIq6EHqMSBh2BDfJX3zR3bggxUdw98FM?=
 =?us-ascii?Q?LJ1kHFVmhtQCgmEwN/+UXHkb3G9qbHKcjtQ9TatXDTy6ViMAoNrzSH6GrR07?=
 =?us-ascii?Q?gCTUAEUKhd/qZw1PbQaDcAVfOxJ8jbN+rGnwoqlLcOh1SQj1fG24hL3V0QiO?=
 =?us-ascii?Q?TRtEsw+tFCrBwCEZs0SU/PQoze9+cKs0bMFITIIpUKOvETgaIBzQzCX79K7Y?=
 =?us-ascii?Q?+VBvRIfPm0hQBT1w30enqEL2iADXllG6ea7n+2i/jtSW35xyWWcQaOCGRvXh?=
 =?us-ascii?Q?p+cCdWSWMx/8hCtP17Qu6dYPgbH/MMubFD0wpN/B2bhtCz1QkTQ3UFOA9jxY?=
 =?us-ascii?Q?+q/BX3nL5E1OI0Ok4UeIPfEeLQeMug80ly+a77nPS6iIyIiWn870pf4WJjye?=
 =?us-ascii?Q?5igRTuOFtSB406wuTj/H5kr1cpMqvm8Nt+ZPxmM0Or1lkhfg10tGpJrTHMDp?=
 =?us-ascii?Q?/kjgSIQHGYW8eyvHRTfthHuLVDovS8qf6NmP2yIP1Dz4+blbE3GRegyENFWV?=
 =?us-ascii?Q?Smc/lRcBxidI12qm547dUqoHy1XbVsdy2RbAOULYcmzJJwTKXNxFXiJCiRC7?=
 =?us-ascii?Q?+d8Z6jkiUb3zD+9myEgc1bTTAhazOklQyHscND/C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f2e3d8-980b-4554-20fd-08db5bc3f11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 19:28:52.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58HdD1MmmXkzCkpKvyUS+DKvlj6mTcGhlSmIVWVkEMfXQRjjTcgScApWP08/a8/mxJhrRCxmPNO2azh16TJhUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7643
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am debugging why a kernel module of ours triggers the IBT (Indirect Branc=
h Tracking) trap, and while doing that, I was trying to write a standalone =
demo that would forcefully trigger it on purpose. This has turned out to be=
 much more difficult than I thought! What can I do to get a module to gener=
ate an indirect branch without an endbr64? Creating the indirect branch its=
elf doesn't appear to be hard:

1. Set up a function call
2. Assign it to a function pointer
3. Call the function pointer
4. ...maybe add a compiler flag so it doesn't optimize the call to a direct=
 branch.

I am primarily building in a Debian environment with gcc (Debian 10.2.1-6) =
10.2.1 20210110. By default, the branch does get optimized away. I had to s=
et the -mforce-indirect-call flag. The endbr64 instruction would still emit=
 so I added a function attribute to suppress it:


__attribute__((nocf_check))
static void indirect_jump_to_me(void)
{
    pr_info("Reached indirect jump\n");
}


I think that took care of my code generation, but objtool is offended by wh=
at I am doing:


/root/module/ibt_test.o: warning: objtool: init_ibt_test_module+0x11: reloc=
ation to !ENDBR: indirect_jump_to_me+0x0
  MODPOST /root/module/Module.symvers
ERROR: modpost: "__x86_indirect_thunk_nt_rax" [/root/module/ibt_test.ko] un=
defined!
make[4]: *** [/usr/src/my-header-6.3.0/scripts/Makefile.modpost:136: /root/=
module/Module.symvers] Error 1


So what do I have to do to tell objtool to allow to me deliberately shoot m=
yself in the foot here?

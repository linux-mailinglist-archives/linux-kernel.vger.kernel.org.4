Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2155FFE86
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJPJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJPJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:58:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265AB2F03E;
        Sun, 16 Oct 2022 02:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665914298; x=1697450298;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UbWEspYOh7/BxoVX3aStbsLVYKgIgHR/rTYvv9d5+O4=;
  b=jR2ROPaY6vdhPII99M7n8Ji9y+RhjqSALVCK3qGOficb5X6I708sK0HT
   JxiBmu3SWa8oqPjF0+qo5RkOntcc6tK6qU4zEKbrb6/DExnxqotGzg6U7
   5Lte/zNWLEyP6ErNHlMKQRAz4cGZm4HNntuINK1SE9gv10qmrCO3X2cKB
   AeTOZhN1LsAftCPyt3k2FYyF57/TFRqYIyA0hGnzG7MiWQic1ZI1XcnN4
   iE33pkw+55gT7FQ4eMfULhQj/ymUZcaqS1WFhmMmceQbX0dvXJ8uMbUp2
   McdIuz0Crf7GJugKdD7DzeEZ7ipyObAqN8ZyyEl43azLDxUrky03il2IC
   w==;
X-IronPort-AV: E=Sophos;i="5.95,189,1661842800"; 
   d="scan'208";a="184916087"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2022 02:58:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sun, 16 Oct 2022 02:58:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sun, 16 Oct 2022 02:58:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ap5i3hhMCu+w/b1a5wDTYgslVAVfZaaozFaDIaApl67TczBnlxZ6vkUm2/4FYIrKbVJTlHTy9q+pUk37sKIN1oPIQQfGSWi+lFZU231Ae4gUQJTYsZZrgkqvGcltlBLbhmxtSFTDISFZCzeFpAPOaUUlE0tK+ypN8/jPcXZhr/Uzc80DmwB9SOHsg4lUTs5nqZBKgsL5TCaQiRxTcTQOkNArQGSTVbLCcliIw3VaFam3M7fpa+PiSWAB2oygudGnNV3UFnjd2sEd042HmvCqic4+sHEFi4LcHt+T/BJMkuw4HYvm7c24bDxyonQHePSi+oKQDNwzaovnl8yG0rBnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbWEspYOh7/BxoVX3aStbsLVYKgIgHR/rTYvv9d5+O4=;
 b=YsW0V8k3WoQJOP6MkGwq6r5XQyrbdV8kXgryATAuNRQvV2VlvRbXon5rik8aIf4jbiEyUb4T9EhI7LV//Ez/zBwE2D4wa7p1RucP1azscy5B5IZ93oqxtX7sfc2zaWCBCv4+5u0xpkGOK12ZNQ4ZUZpXnjECglahExG4Q4YmtYAKhAVcrrYk4GBkUmxqWaHhMGkIuIwJtYuie0gaK9vyfnGp9Xv6rBhzVRi60WF+wAIafQhetrh9YBUYq2P6HwhbykUYwmdMIb78ywH5p72EVODOyT3GhwJEYF+QZMtflddFxriF/xTbsQFOoe8f0cGQNxZPIoJHRKdxao7J8iUsWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbWEspYOh7/BxoVX3aStbsLVYKgIgHR/rTYvv9d5+O4=;
 b=VwXosQQsrjTFA46a4BOZjMex8BHLPXv4PxddIdvIJgDDFKktT1fDgwwSeMb3/GFz9MpE8Pk2zgz1hWkn5hnqtlo5/pHu2+kjvU43Rw2BOv1uiW7VIk6pTpPwW+RS6JB9nirxbGSbcwAv82mdlxhpEI0+ZptCQZv/hn0gNWxkvVU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5425.namprd11.prod.outlook.com (2603:10b6:610:d0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Sun, 16 Oct
 2022 09:58:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::1304:e061:45a4:23e1%5]) with mapi id 15.20.5723.030; Sun, 16 Oct 2022
 09:58:10 +0000
From:   <Conor.Dooley@microchip.com>
To:     <gregkh@linuxfoundation.org>, <Brice.Goglin@inria.fr>,
        <atishp@rivosinc.com>, <sudeep.holla@arm.com>
CC:     <stable-commits@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Patch "riscv: topology: fix default topology reporting" has been
 added to the 6.0-stable tree
Thread-Topic: Patch "riscv: topology: fix default topology reporting" has been
 added to the 6.0-stable tree
Thread-Index: AQHY4UJkPqkGJRAl8U+YjHH6iW201a4QyRMA
Date:   Sun, 16 Oct 2022 09:58:10 +0000
Message-ID: <f97b84b7-9086-f83d-4edf-751873b7b26a@microchip.com>
References: <166591276524312@kroah.com>
In-Reply-To: <166591276524312@kroah.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CH0PR11MB5425:EE_
x-ms-office365-filtering-correlation-id: 7573e274-d9fa-44bd-1798-08daaf5ceeda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hK8Jzid3MypTzbqLviYk7hs7iXQ1s0p1sVxzwZkgG5sJeRthGow3hSWha1axHao9FrFqrKLyyUw1NyBR7sLq6aXd6M753zq/6Y7fNprcJSOEeiP8SbkhZhHNZ9ZpL/+8BjFwDtLWUeC/NUNbZ0twZfybUq5SRWJZFwQYogjtp0/z5eolzF1fiM218FRLx7c9veK9xFDllpdm1ti2SS+y1EfkF4mnCeOXm2lm26rLg3oCwe0ji+F6UmH4P2XpafvOZTvET9k3eyfSnbhkz7I1quC9eidFjsQkmBdlKSlCoB1c4rV5V3t7psaqDk3v6cHNk8JTIQQpvd7rfpiIxbIYSoM6Vwkh3+GTt1yCi0slTCbkuDOAIN3ekKEZ+++3O4oU0gZdgYKFHDBwr5nFF/t0aiAsKoyvCEZHdv8SQ2V2QjvQpAryi/QfzwiT0hQvvOO67WCkDFG5ONHDSt9AoCEuGNx24NfpLYyFBEukmDQ2HzEyf5LvIbFcWteLtA63tPN6+xykd4pCArWubJycIzgVpcB5iztTtFW0ua6OGSoFjcWnt+CssUVMSuod5AOXWGSlOLwFAxoHhN8IWL71W776YoyUT0txoelmE/NMqSI1/kt/tV8Srm/pgTN49zmmyF0GImpubp93qKR3LaIUYh24hjWAYGMPU8fkvbvpmGJFkOeArlBGwzPOOzPcem0aefmWYqr+Bi5OMuMUzXqiTp8bvwcryksvbRwkf8NQ0tohiLzlDWpv8hzzCHEMCXHtcoZotW/ALYFEXowpZuQ2dQXD9gf9fnCHGFFpKtxtOxOXLgyYZORO57T/qwpj9uJRMnt2gAIlgY0I7idcGxJfzSm+Q3G6Cz3ZdeL5cBnJ00cqR8Xjy5ZyD+ivx9n/OYXv1nGDn5GcZ3oxD8b+rgxWawCwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(110136005)(31686004)(54906003)(76116006)(8676002)(64756008)(5660300002)(316002)(478600001)(66446008)(6506007)(53546011)(41300700001)(26005)(6512007)(71200400001)(186003)(6486002)(2906002)(4326008)(966005)(2616005)(8936002)(36756003)(38070700005)(83380400001)(38100700002)(66556008)(66476007)(66946007)(91956017)(31696002)(122000001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDBrcTRocnZWaGNyaHBPcnBSODFNaXlwZUNwelVMWUgvTjJTUmU0UEI3NUZN?=
 =?utf-8?B?eE1iY3hpZjN3Sm5KeWRsTTlLN1NqdTBmaWdQOVdLVHdyYzNnQVN5dWZiRWI3?=
 =?utf-8?B?dUJHSnl6MXZyRlBpU3BhSHF2eFhORGdNVVNORUpwVnlLN1hGRWpadmVOV2pi?=
 =?utf-8?B?cnNsdnViempjTFFnSkUyYXFPcDFJVWVRYjVmREl5WDJHMElsZjhONU80NE94?=
 =?utf-8?B?aXRkSmpMN2cwRUwyUHpkQUZwTlY1U1NWM2t0Q1hIeXR5WGdHbEpBaVhJWXMw?=
 =?utf-8?B?RmNUL2FqWDNvMXlyMGRWM0dzanVBNDhhaTVjTzc0cnJhMkNQMWJUVTNmT3pj?=
 =?utf-8?B?RldmYzFEMnJCYzg3NG9lLzBqWFpuMTdsaW15Syt4NlgxK25xdkhDMG1tcUFk?=
 =?utf-8?B?VVhYSUFmVFZHVGxiZXlHMFoyb0VlMlpscmE4amNtQmdoaVcvNVZEVUVHQ1c5?=
 =?utf-8?B?SjgrVDZ6b1UvV0FWYUNTUHIxQS8vWm15Vkt3ZnNobmpsNHliVEQrWWR5MVlK?=
 =?utf-8?B?bEhBY1ExSTNNNFp6cklaS3E1dk02ejA5SVRjSlhvS1JLMW4ra290dk1xRkda?=
 =?utf-8?B?UTVrVWdlYnJ0TXFaOXRKM2J3TjV6VDJocDJRek5mUHJpVG9uN0tqR1JKZ2hy?=
 =?utf-8?B?dE0xUnNlNzROWDNzekFwU1Y0NTNjVUFnMWJjMDJzaTBFT0pWcEtZZWdHUERF?=
 =?utf-8?B?NzdtNXFyeFk0bWlnSW9TNUZVbmRabmh6c2NVNjhodnNvaE9iSUZjTU1wbC81?=
 =?utf-8?B?NFQ0K3ZRcFZOa3V4dlpDK1h3UGJ1dzJabG13NXByQnl5c2duTjFic3plS25y?=
 =?utf-8?B?dEZBdC9MNGcwZXRSSnppeWpKcWk4dmFiWTROMXFwZHJFVThnL3VYeGN4Rllm?=
 =?utf-8?B?emtlazZRaEc3akFSQU9oYlhlNDh5OWNwTXZSeHFTb0lLNW9NejNoaFQ4aHhI?=
 =?utf-8?B?YXdKNlU2dVUyQXhQcllqbnZ4MDVPNmVMTlNSK3RNUC91RTlwclRqZ2hiRlpE?=
 =?utf-8?B?Z1BFREc2Rk1nUlBYYU16R00zZjYzczFUZ0NEVjJDSHRUc2s0ZDBMcVMxNUhi?=
 =?utf-8?B?SSt5VDZVNklielVBM1phcjZYQks4LzhDM20xOGJKRWNzNmtuK3ZaMVJ0WThL?=
 =?utf-8?B?TkJNc2ZERmVYMmRiVU10djdsSS9FdThIcXBDazR6ZU9McXBTbGVlclliN2hE?=
 =?utf-8?B?MHl5VU5MZmN5RVkvbGM0OTVQYWgwYXRWbFN1c2U3VXBiSlNZWXZ1TEdVd3U5?=
 =?utf-8?B?bWkxOE12MkhTSElrdjI4cndWSW5lSXU2VktRQTV3WUdBTmlDTFJwdVFrT2hO?=
 =?utf-8?B?UnpvWml4RjB0Qml4Z0lkbkljS1ptc3VrTEFnckdXdzcyWjlQMFcySVpoMEVN?=
 =?utf-8?B?cGU4VVRNTW1OS1dLbnJXcnVUR2E0QTBZQml3Q3Fzay9IVjIrNkZBeDhsaXdQ?=
 =?utf-8?B?M0xzTXVOd2VSOWI2dEk4UFE0Y1VUK0xyVHY3QmNuNWlUc25DK3FPVHBKZEQr?=
 =?utf-8?B?TStJYVZJaU1sMUpPaFN2cW5TeXI3ZWd6KzdDMjZjODhnelk1ck1WdGtITmVK?=
 =?utf-8?B?V1BWbm5rRHBlMC9sZVZ4SFVoUHh4SUs3a251cE5sK3RCYk5rQ2ZzSFVSM2h3?=
 =?utf-8?B?TE1QY3NCSVUzQ0FVQm9NZFdBeEhJV25FTmtTZFZvdi9zT1JHVkJqcFdpNDBI?=
 =?utf-8?B?Uk9VajQ3SDRMTlJicEJBWjA0NWRwUXlFc0lJN3B6dXZjZVVzL0NPazNTVjNw?=
 =?utf-8?B?dFRLWmt2R1Q4aktBclo2NEovQ0ZLcXIrNVhKNG9LcmtwL3BISmZ5em1jb3k1?=
 =?utf-8?B?SWpUYzZ3Y0c3RFphMGVlbkMzWFJHWWNjSk5XNmw5aDM2Zzc1L3puSE05S1hQ?=
 =?utf-8?B?elZHd0pMSHpDNlZMOUNrRzdZNGpkRFNSVDBpMXNHUEZZQ1daTk14bHR0aWht?=
 =?utf-8?B?cmttODNxQWduYW1GV0N5TytrSWxEOVV5ODFzd0RTeFVyZHRGRTlIdmV3T3k3?=
 =?utf-8?B?TWpiWWpzcjZ5bkswL1dEYnNycnVmTWx6RDM3UExrRHg4MzJuVFJYRDBLRUpy?=
 =?utf-8?B?am9SS3BIVksxTnk0VjZwb2txajMvZ1ltU3JJdWRsTm1ZZmJDUTFXNHp3ZktS?=
 =?utf-8?B?WllaUC9LQ2NmU3BEekdGWmdmM25oT3hXc1pBVW11WklUQVZac0IwSW1XSW12?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <954DBD3123322E448EC94C8B90282D3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573e274-d9fa-44bd-1798-08daaf5ceeda
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2022 09:58:10.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srDpmofyZYcK6qKw4q2i4gWQf0vpqohkVuaT4fytWvME1Ps25FwTUc2wtAnsmywUuZHaCGwFZev2CfgA6JvguWJ0X8KQrWPkBLyjq+tyugc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5425
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMTAvMjAyMiAxMDozMiwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhpcyBpcyBhIG5vdGUg
dG8gbGV0IHlvdSBrbm93IHRoYXQgSSd2ZSBqdXN0IGFkZGVkIHRoZSBwYXRjaCB0aXRsZWQNCj4g
DQo+ICAgICByaXNjdjogdG9wb2xvZ3k6IGZpeCBkZWZhdWx0IHRvcG9sb2d5IHJlcG9ydGluZw0K
PiANCj4gdG8gdGhlIDYuMC1zdGFibGUgdHJlZSB3aGljaCBjYW4gYmUgZm91bmQgYXQ6DQo+ICAg
ICBodHRwOi8vd3d3Lmtlcm5lbC5vcmcvZ2l0Lz9wPWxpbnV4L2tlcm5lbC9naXQvc3RhYmxlL3N0
YWJsZS1xdWV1ZS5naXQ7YT1zdW1tYXJ5DQo+IA0KPiBUaGUgZmlsZW5hbWUgb2YgdGhlIHBhdGNo
IGlzOg0KPiAgICAgIHJpc2N2LXRvcG9sb2d5LWZpeC1kZWZhdWx0LXRvcG9sb2d5LXJlcG9ydGlu
Zy5wYXRjaA0KPiBhbmQgaXQgY2FuIGJlIGZvdW5kIGluIHRoZSBxdWV1ZS02LjAgc3ViZGlyZWN0
b3J5Lg0KPiANCj4gSWYgeW91LCBvciBhbnlvbmUgZWxzZSwgZmVlbHMgaXQgc2hvdWxkIG5vdCBi
ZSBhZGRlZCB0byB0aGUgc3RhYmxlIHRyZWUsDQo+IHBsZWFzZSBsZXQgPHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmc+IGtub3cgYWJvdXQgaXQuDQoNCkhleSBHcmVnLA0KVGhpcyBicmVha3MgdGhlIGJ1
aWxkIG9uIDYuMCAoYW5kIEkgY2FuIG9ubHkgYXNzdW1lIG9uIHRoZSBvdGhlcg0Kc3RhYmxlIHF1
ZXVlcyB0b28pLg0KDQpJIHB1dDoNCj4gQ0M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA0NTY3
OTdkYTc5MmY6IGFybTY0OiB0b3BvbG9neTogbW92ZSBzdG9yZV9jcHVfdG9wb2xvZ3koKSB0byBz
aGFyZWQgY29kZQ0KaW4gdGhlIHBhdGNoIGl0c2VsZiwgZGlkIEkgc3BlY2lmeSB0aGUgZGVwZW5k
ZW5jeSBpbmNvcnJlY3RseT8NCg0KVGhhbmtzLA0KQ29ub3IuDQoNCj4gDQo+IA0KPiBGcm9tIGZi
ZDkyODA5OTk3YTM5MWYyODA3NWYxYzhiNWVlMzE0YzIyNTU1N2MgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
DQo+IERhdGU6IEZyaSwgMTUgSnVsIDIwMjIgMTg6NTE6NTYgKzAxMDANCj4gU3ViamVjdDogcmlz
Y3Y6IHRvcG9sb2d5OiBmaXggZGVmYXVsdCB0b3BvbG9neSByZXBvcnRpbmcNCj4gDQo+IEZyb206
IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IA0KPiBjb21taXQg
ZmJkOTI4MDk5OTdhMzkxZjI4MDc1ZjFjOGI1ZWUzMTRjMjI1NTU3YyB1cHN0cmVhbS4NCj4gDQo+
IFJJU0MtViBoYXMgbm8gc2FuZSBkZWZhdWx0cyB0byBmYWxsIGJhY2sgb24gd2hlcmUgdGhlcmUg
aXMgbm8gY3B1LW1hcA0KPiBpbiB0aGUgZGV2aWNldHJlZS4NCj4gV2l0aG91dCBzYW5lIGRlZmF1
bHRzLCB0aGUgcGFja2FnZSwgY29yZSBhbmQgdGhyZWFkIElEcyBhcmUgYWxsIHNldCB0bw0KPiAt
MS4gVGhpcyBjYXVzZXMgdXNlci12aXNpYmxlIGluYWNjdXJhY2llcyBmb3IgdG9vbHMgbGlrZSBo
d2xvYy9sc3RvcG8NCj4gd2hpY2ggcmVseSBvbiB0aGUgc3lzZnMgY3B1IHRvcG9sb2d5IGZpbGVz
IHRvIGRldGVjdCBhIHN5c3RlbSdzDQo+IHRvcG9sb2d5Lg0KPiANCj4gT24gYSBQb2xhckZpcmUg
U29DLCB3aGljaCBzaG91bGQgaGF2ZSA0IGhhcnRzIHdpdGggYSB0aHJlYWQgZWFjaCwNCj4gbHN0
b3BvIGN1cnJlbnRseSByZXBvcnRzOg0KPiANCj4gTWFjaGluZSAoNzkzTUIgdG90YWwpDQo+ICAg
UGFja2FnZSBMIzANCj4gICAgIE5VTUFOb2RlIEwjMCAoUCMwIDc5M01CKQ0KPiAgICAgQ29yZSBM
IzANCj4gICAgICAgTDFkIEwjMCAoMzJLQikgKyBMMWkgTCMwICgzMktCKSArIFBVIEwjMCAoUCMw
KQ0KPiAgICAgICBMMWQgTCMxICgzMktCKSArIEwxaSBMIzEgKDMyS0IpICsgUFUgTCMxIChQIzEp
DQo+ICAgICAgIEwxZCBMIzIgKDMyS0IpICsgTDFpIEwjMiAoMzJLQikgKyBQVSBMIzIgKFAjMikN
Cj4gICAgICAgTDFkIEwjMyAoMzJLQikgKyBMMWkgTCMzICgzMktCKSArIFBVIEwjMyAoUCMzKQ0K
PiANCj4gQWRkaW5nIGNhbGxzIHRvIHN0b3JlX2NwdV90b3BvbG9neSgpIGluIHtib290LHNtcH0g
aGFydCBicmluZ3VwIGNvZGUNCj4gcmVzdWx0cyBpbiB0aGUgY29ycmVjdCB0b3BvbGd5IGJlaW5n
IHJlcG9ydGVkOg0KPiANCj4gTWFjaGluZSAoNzkzTUIgdG90YWwpDQo+ICAgUGFja2FnZSBMIzAN
Cj4gICAgIE5VTUFOb2RlIEwjMCAoUCMwIDc5M01CKQ0KPiAgICAgTDFkIEwjMCAoMzJLQikgKyBM
MWkgTCMwICgzMktCKSArIENvcmUgTCMwICsgUFUgTCMwIChQIzApDQo+ICAgICBMMWQgTCMxICgz
MktCKSArIEwxaSBMIzEgKDMyS0IpICsgQ29yZSBMIzEgKyBQVSBMIzEgKFAjMSkNCj4gICAgIEwx
ZCBMIzIgKDMyS0IpICsgTDFpIEwjMiAoMzJLQikgKyBDb3JlIEwjMiArIFBVIEwjMiAoUCMyKQ0K
PiAgICAgTDFkIEwjMyAoMzJLQikgKyBMMWkgTCMzICgzMktCKSArIENvcmUgTCMzICsgUFUgTCMz
IChQIzMpDQo+IA0KPiBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAjIDQ1Njc5N2RhNzkyZjog
YXJtNjQ6IHRvcG9sb2d5OiBtb3ZlIHN0b3JlX2NwdV90b3BvbG9neSgpIHRvIHNoYXJlZCBjb2Rl
DQo+IEZpeGVzOiAwM2YxMWYwM2RiZmUgKCJSSVNDLVY6IFBhcnNlIGNwdSB0b3BvbG9neSBkdXJp
bmcgYm9vdC4iKQ0KPiBSZXBvcnRlZC1ieTogQnJpY2UgR29nbGluIDxCcmljZS5Hb2dsaW5AaW5y
aWEuZnI+DQo+IExpbms6IGh0dHBzOi8vZ2l0aHViLmNvbS9vcGVuLW1waS9od2xvYy9pc3N1ZXMv
NTM2DQo+IFJldmlld2VkLWJ5OiBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0K
PiBSZXZpZXdlZC1ieTogQXRpc2ggUGF0cmEgPGF0aXNocEByaXZvc2luYy5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9LY29uZmlnICAgICAgICAgIHwgICAgMiArLQ0KPiAg
YXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jIHwgICAgMyArKy0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gLS0tIGEvYXJjaC9yaXNj
di9LY29uZmlnDQo+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZw0KPiBAQCAtNTIsNyArNTIsNyBA
QCBjb25maWcgUklTQ1YNCj4gICAgICAgICBzZWxlY3QgQ09NTU9OX0NMSw0KPiAgICAgICAgIHNl
bGVjdCBDUFVfUE0gaWYgQ1BVX0lETEUNCj4gICAgICAgICBzZWxlY3QgRURBQ19TVVBQT1JUDQo+
IC0gICAgICAgc2VsZWN0IEdFTkVSSUNfQVJDSF9UT1BPTE9HWSBpZiBTTVANCj4gKyAgICAgICBz
ZWxlY3QgR0VORVJJQ19BUkNIX1RPUE9MT0dZDQo+ICAgICAgICAgc2VsZWN0IEdFTkVSSUNfQVRP
TUlDNjQgaWYgITY0QklUDQo+ICAgICAgICAgc2VsZWN0IEdFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJP
QURDQVNUIGlmIFNNUA0KPiAgICAgICAgIHNlbGVjdCBHRU5FUklDX0VBUkxZX0lPUkVNQVANCj4g
LS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvc21wYm9vdC5jDQo+ICsrKyBiL2FyY2gvcmlzY3Yva2Vy
bmVsL3NtcGJvb3QuYw0KPiBAQCAtNDksNiArNDksNyBAQCB2b2lkIF9faW5pdCBzbXBfcHJlcGFy
ZV9jcHVzKHVuc2lnbmVkIGluDQo+ICAgICAgICAgdW5zaWduZWQgaW50IGN1cnJfY3B1aWQ7DQo+
IA0KPiAgICAgICAgIGN1cnJfY3B1aWQgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ICsgICAgICAg
c3RvcmVfY3B1X3RvcG9sb2d5KGN1cnJfY3B1aWQpOw0KPiAgICAgICAgIG51bWFfc3RvcmVfY3B1
X2luZm8oY3Vycl9jcHVpZCk7DQo+ICAgICAgICAgbnVtYV9hZGRfY3B1KGN1cnJfY3B1aWQpOw0K
PiANCj4gQEAgLTE2Miw5ICsxNjMsOSBAQCBhc21saW5rYWdlIF9fdmlzaWJsZSB2b2lkIHNtcF9j
YWxsaW4odm9pDQo+ICAgICAgICAgbW1ncmFiKG1tKTsNCj4gICAgICAgICBjdXJyZW50LT5hY3Rp
dmVfbW0gPSBtbTsNCj4gDQo+ICsgICAgICAgc3RvcmVfY3B1X3RvcG9sb2d5KGN1cnJfY3B1aWQp
Ow0KPiAgICAgICAgIG5vdGlmeV9jcHVfc3RhcnRpbmcoY3Vycl9jcHVpZCk7DQo+ICAgICAgICAg
bnVtYV9hZGRfY3B1KGN1cnJfY3B1aWQpOw0KPiAtICAgICAgIHVwZGF0ZV9zaWJsaW5nc19tYXNr
cyhjdXJyX2NwdWlkKTsNCj4gICAgICAgICBzZXRfY3B1X29ubGluZShjdXJyX2NwdWlkLCAxKTsN
Cj4gDQo+ICAgICAgICAgLyoNCj4gDQo+IA0KPiBQYXRjaGVzIGN1cnJlbnRseSBpbiBzdGFibGUt
cXVldWUgd2hpY2ggbWlnaHQgYmUgZnJvbSBjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbSBhcmUN
Cj4gDQo+IHF1ZXVlLTYuMC9yaXNjdi1hbHdheXMtaG9ub3ItdGhlLWNvbmZpZ19jbWRsaW5lX2Zv
cmNlLXdoZW4tcGFyc2luZy1kdGIucGF0Y2gNCj4gcXVldWUtNi4wL3Jpc2N2LXBhc3MtbW5vLXJl
bGF4LW9ubHktb24tbGxkLTE1LjAuMC5wYXRjaA0KPiBxdWV1ZS02LjAvcmlzY3YtdG9wb2xvZ3kt
Zml4LWRlZmF1bHQtdG9wb2xvZ3ktcmVwb3J0aW5nLnBhdGNoDQo+IHF1ZXVlLTYuMC9yaXNjLXYt
cmUtZW5hYmxlLWNvdW50ZXItYWNjZXNzLWZyb20tdXNlcnNwYWNlLnBhdGNoDQoNCg==

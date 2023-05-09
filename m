Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129236FBCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjEIBtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjEIBtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:49:42 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02BFA24E;
        Mon,  8 May 2023 18:49:40 -0700 (PDT)
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348KNv7J008354;
        Mon, 8 May 2023 18:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=ld6x/MJzGvXruu4h7GLQ8wEKrAtJO0jXssW4TpbbUrU=;
 b=fgk6AiH5QTEbc1lGi6drdlYfqY68s68XPkqpNN5V4OmWggSOnkCsMev+MdqzbcAtBQxT
 ZY2fooRoT8nHPVyeMYHdxWElgYs/fIcuRhSpxYBuGuUabwYTgHIz31eVwF+ky7HVIbGu
 YWSlQJa2/nqNU3Aoir8hwIukOSj/K3ahznO776/cqT107Cpkq/97jx7kdd5PdYiODlOo
 EMWFX3OIiGOvUYLehkskMOvW9alwOOsLN8DaIeArkV1d4OdNKjl1+fmxOILPLMPp8C8K
 FJNhkLC7vg3+3kHwscRqqt2t/+8VYkR0HInbJFq7E90PoQr2kSPHE82ZYlfnOToeB/fi Cw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qf835ghna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 18:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9N2QIrCgCE/1IpSyp9ss48CLa5Y1bhqg15In3L7r3fvz8cZK1+zuhnwoH3qE1mjXHq1ST6rrC3wrtrKOEVAv6unvWA4f7jFr71/g7jTa9nmF1PLSstYr4YmnvDvqfB4B3EhZ5X/RkezcVDIxeR7jhs62rk7kNqGY+z9Kh8epUhFdu9ipk8YiRB2EGde6L1V+8UTLnye5LLcyAViuAwtPfUduKEeOymOpjkgMsq6xu06vEgVPqMNhivavmIHkM0SRbcUJ27ZgwAA4OB/+L5XIhC2FkKmG+FMKbaPBYuO9OXqn76vbnl7hSrWaR/bmXUwARkNgibsGTUeqHmJlpkThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld6x/MJzGvXruu4h7GLQ8wEKrAtJO0jXssW4TpbbUrU=;
 b=R96aUcrovhvCrxQIthGiGQWjTJhaKkrPCQEzmSqhKZuFkxAWnkEPmzMIWDaPWpzMSQYYJ6V4q9mKse1gEYkMRTERYfFbj8OiEiUABVaXn3lyULcWRA10tMizGW3cKScUXb7n5maUjY+ScgFJCTqR4gmiZHEGzPmOj+1h82hDunPQedhKVKvZhopFsej1cpah6mGKCf78rT5GmtBbyz/BZ3PZlkLq4N7bLBsG9HOtg47IsTuET9h3wKAKlNWIis0VClEb7/1vXdJNyna4ynFio/aJC4nhJW+Gl5nVU3x2yknuBJe5KZw85McRUg1icRut6GdssmMYxH+fG9QNimtBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld6x/MJzGvXruu4h7GLQ8wEKrAtJO0jXssW4TpbbUrU=;
 b=kOdA+uO5FJI+LgzChz5/6NfWRz3l1yYyuR7684uE+bsyuRng3rn0ZocaAjEKqfjODmo2bHAkIku4AVnP0y1iuAm1hEiAdaTnIwrpEX604yrCsWJ8oqF853r8Aoh0WINlP/jygRsYICIX5xnujaJkN1wO6oPWPRRy9liJmZVZzHvsg2+GJe1tOi08RxAYsNNERyWUluYOvcrg9TiiA8N6n9boUCws0bzAR30lxelVTi7NBA458JTT2iGI9OalpVX26mNDOMEm06rMASRTj0HkDoMeQaf1Q0T/7ZcftBY7Fpf462r+UAiXe4zm8u9ZAzOpvgHsntzSbIXAMdL/Yu5KEg==
Received: from CH0PR02MB8041.namprd02.prod.outlook.com (2603:10b6:610:106::10)
 by MN2PR02MB6896.namprd02.prod.outlook.com (2603:10b6:208:20a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 01:34:26 +0000
Received: from CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54]) by CH0PR02MB8041.namprd02.prod.outlook.com
 ([fe80::e48:dd5d:b7e4:4d54%2]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 01:34:26 +0000
From:   Eiichi Tsukata <eiichi.tsukata@nutanix.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Subject: Re: [PATCH 0/4] audit: refactor and fix for potential deadlock
Thread-Topic: [PATCH 0/4] audit: refactor and fix for potential deadlock
Thread-Index: AQHZgYLqBTlbVO45nUiARiTa6bZEZ69QadWAgAC/3AA=
Date:   Tue, 9 May 2023 01:34:26 +0000
Message-ID: <506299C8-B1D0-457D-881B-BF639224A3AD@nutanix.com>
References: <20230508075812.76077-1-eiichi.tsukata@nutanix.com>
 <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com>
In-Reply-To: <CAHC9VhSh3_hiwzKN_YPKyO-s2tE5V0URTMrg_tbR5=cKkjzLrw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8041:EE_|MN2PR02MB6896:EE_
x-ms-office365-filtering-correlation-id: eac8e8db-fe40-4695-c23c-08db502d866b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVYAxq+6GIeG3sSMleAtyJyCco0vGlyyAF+ks/wGdns/0ngaoqToJBLqtMNOwhpO8MNrJeyz0LB9OokxBSaBozCm8lr2Bc4+uEASHTuJ5AGUZ8enCEcVUulIoXhQAJJz6IsRnZAKIKHECA8PRggLuJfBHW2OEQGhI9WFd/DDUo8NPoX5TaqfLdPsImZ+F7MfekRmNBjip/5ZwMvN3jZmg5d+yIEDCMPnGYkTLCABF7W8NH6S69jq5EqOuq3QrXXeyBPv07cQWrnlvarYPxpWM0SsVLcbMsy+vZNsK6zIzeRJFoNRcFF2F9il2VcjdkW7fu6KNM7amKVgFfltX4sCkx0k2//5L0kuAkWJaOrdz2Ai9lN7W0lQ5Fsl0DmY7wDFOhMtUM3KbbXbi5l+MjYrwHkdkNQ4nZy2ElrR4r5/nH8fdz49O+HNppvE8cymWeOomAeIjslVAma6WjHyjOjmJNsG4xTawyZNkacQxYhfZNy0FEewAtzKN1W8zfVn+Wf1lVt+xJL5xnNxBFQTZENGmlYiHowGA77wa4S80gyGd66m0F7vkxnllNusXfaIx2/26xhdD+2w5L+tPSB2recxmo6ExKrsgU48y5B2bMrZqW2Nhi3h7ROTkSxxbqQ2RuYkEs3aEkY45TwnWaBd7aB24w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8041.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39850400004)(366004)(396003)(346002)(451199021)(4744005)(54906003)(4326008)(2906002)(5660300002)(8936002)(478600001)(316002)(66476007)(6916009)(64756008)(66446008)(8676002)(66556008)(41300700001)(71200400001)(76116006)(44832011)(91956017)(66946007)(6486002)(6512007)(53546011)(26005)(6506007)(186003)(2616005)(36756003)(83380400001)(38070700005)(33656002)(38100700002)(86362001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9YdytBOFl4NE5ObUpWTFFwVTV5ZmRxVTJIZ3VNWHp2OXdjY3BHbnhoWEJD?=
 =?utf-8?B?RTdseDZXSkR4UXpTZndoUGx3TTQyRmoyL0JKYW40bDFMR1cwZ2x6V0hhWUZr?=
 =?utf-8?B?aWRuYVVBUlRtYkwya1E4cEdneGN0WTA2ZGZ4VXZlSTVZL0FtS1U0bDRPT3dy?=
 =?utf-8?B?Sk9FSko2eGM1SDgwdXYzazZLQTBFYUh5OERrcUtSLzBINEdEQ2ZHT0djRjhB?=
 =?utf-8?B?b1RtOU5XM09JTGVleHdLcnpDa3NkRExPLzR4OTcwb1VBSUdjQThldERkaysv?=
 =?utf-8?B?b0wwYThpWjB5cjI5MHdYQk5nbFNRRTdtZGhEbG8zQ1IvbHJ0SUNpZU01eWg2?=
 =?utf-8?B?dks4Z1hFd0tVUkJLS0VpcDRtMTJUdHhSZWEzN0pPMFc2SXZhTHJUZG55WkY5?=
 =?utf-8?B?eEt6WmhySnh5a2RRcm5wY081bnpLVGlWUkw1cEF6OXR3dGoxVEwwdHBhSXY2?=
 =?utf-8?B?aW5IQWNyLzdhVnVQRWFmaDVkMmFIenF3VmxnaHNsNTZRTDlEWktLWW12cG1k?=
 =?utf-8?B?WkxpZ0k0SnlRL3JPTlpyQnVjNFVmZC9KT0lpVTNUQ1c2d1FSUmd3b0VvYWlk?=
 =?utf-8?B?Vmh6KytJV0ZmV3RCazJwNDd0SzRQQmpNWVpnOGpjNVhwdTJYdjNkd2krNGRJ?=
 =?utf-8?B?RzE2ZnJ1VjdlTTFBeTY3ZTdONnlVZHRZTXYzckUwOFIrdEhkRVdXa1h3VVdJ?=
 =?utf-8?B?dUlqMUNHdlJvZDdTaWtBK2xXTk1HWElYVURkSFpwQ1lDb3kvdnY4aGZxOHRW?=
 =?utf-8?B?bnNsaW5peDd3ZkltS25Gdm50OWdHWDlEcTczMFQ0RkpMWXRXdytpeXFTQkZQ?=
 =?utf-8?B?MkhwbjVoZm1sUllocWVIVzBhTHJtUFJvSi9Qci9SdVNIUzdwMGFhSFlER1RH?=
 =?utf-8?B?Mld4R203NE5IYytrT3RDeWVXQTc2aVRLWjJudlUvWG51WjdVcE9OQW5TUVF0?=
 =?utf-8?B?SWxRZjhzenpiaEd5YjNsK29vZitEcDJnNzIrQW9JaDBWM1pZYUlUVVZ0THMy?=
 =?utf-8?B?U0E4dG00RlMwR1VzYUhmSTIyWjFxYjZERnVrUlVOTVZjZU9qWUFnQlZsL25l?=
 =?utf-8?B?MDJqSFpiZlh3Z1RZY0FxNTBLcjk3WUZyRWhFcTR5VW9paFVJR1RKRTJSbWt0?=
 =?utf-8?B?RlRJbG5EZnFPMUUzU3R1MDRBbFJQR21aYjFMQllJUFlXdzdVNTQwb1BZaUhO?=
 =?utf-8?B?TXU5V1c4eTdlanhFeU1vRE1FMWVNdmxVYTg2Mmk4dHF6QjF5bW5kY00zRk9t?=
 =?utf-8?B?aXZIVUFHVjRmbWExMHNadUwvRG9jS2craWhjRzBxU1ZZa2xtZGIrb3JEWEJN?=
 =?utf-8?B?Y2lCS3g3MWdOVXBkME1XUWk4eGcvc2lNYnhXQzZtYWw2MVRuaHVCMitRSnpM?=
 =?utf-8?B?SDFvVzdEUURKbjloUmpOdTJHWVV1c2Q0STc1cTBCSkZlVUJDWmlwajBicFl4?=
 =?utf-8?B?aWs2OWJHZFNTNGh6SWRqK0lHc1Y4SFVUYUlMbmpEcEVGUHhYR21jMGpjQkRs?=
 =?utf-8?B?UUg5QURnVXVRZVJWVFNwWmdIVTQ4ZnVEVTlUZjMwY3R5ejlFa3hSRlpMVW9s?=
 =?utf-8?B?cHR0MjlKKytLaXBEOXhiZXJFTjViUVJPWnd5TEFZT2NEZW83MmpLeEhad1VJ?=
 =?utf-8?B?cjI2Tk1KbE5SV2Vrc0YwNzVISnA5WnQ2bFhELzRDZUpGWjkxZko0K0xWK1Q4?=
 =?utf-8?B?UEpVQnBNQmUwQWpGMUFjWEZEQWxYczNPMVNMYTBpMmhRZlgyajdzaFlXRWEv?=
 =?utf-8?B?L0pZait3bGdSMWJ3N3BYSkMxUk5pa0ZzRno3OGxmcEd3UlRJQ2R0MVJTQWJs?=
 =?utf-8?B?U2FQT0VBRlIrcWtkZUN5ZGFqc1F3VzhhWGN6NnpCTlBEaUxrODl2dDR5SDQw?=
 =?utf-8?B?SGVUM0JueCtWNE5sOVpiaHBtay9ubE1VWmRVRTlHckNhL0t3ZEYyTnEwaDlC?=
 =?utf-8?B?aURhR1MzSGlVcWduZnRJU240b3EwUnZnTGNsWkxXSjZFUW84eE95OUVyVHhV?=
 =?utf-8?B?L3BJT2RSb29TSUhGbzI2Um1sMUdVaGdGdzRocThFRHAycXJzODFidHFjWUJm?=
 =?utf-8?B?L0g3eERGZ2FyWGltSmlGaU1DaFRJaVJvdkNBb3o0ZjBZWktGUFhNUW5uaHF5?=
 =?utf-8?B?cnZiKzlzS0V2YkZpbEJ3VXNxZFdFYkZlaTNQamE2eXgyZ2VsdlcwY3pwczdz?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4133AD9721ABB94EBB943BEC4D6133E3@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8041.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac8e8db-fe40-4695-c23c-08db502d866b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 01:34:26.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wpq/OnSHkxJvzcv7jQz1Y+hJRJoCrgje0Tj4uSSTwh+fn7uBqLR2EWeqgZhZuUA2z2OfMATrUy78Ljq0JfBi0rn00tbGrpovOuFNlD85yvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6896
X-Proofpoint-ORIG-GUID: rba6BUVC3shEarxUkgWtMPYcSEUCpNhQ
X-Proofpoint-GUID: rba6BUVC3shEarxUkgWtMPYcSEUCpNhQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWF5IDgsIDIwMjMsIGF0IDIzOjA3LCBQYXVsIE1vb3JlIDxwYXVsQHBhdWwtbW9v
cmUuY29tPiB3cm90ZToNCj4gDQo+IE9uIE1vbiwgTWF5IDgsIDIwMjMgYXQgMzo1OOKAr0FNIEVp
aWNoaSBUc3VrYXRhDQo+IDxlaWljaGkudHN1a2F0YUBudXRhbml4LmNvbT4gd3JvdGU6DQo+PiBD
b21taXQgN2ZmYjhlMzE3YmFlICgiYXVkaXQ6IHdlIGRvbid0IG5lZWQgdG8NCj4+IF9fc2V0X2N1
cnJlbnRfc3RhdGUoVEFTS19SVU5OSU5HKSIpIGFjY2lkZW50YWxseSBtb3ZlZCBxdWV1ZSBmdWxs
IGNoZWNrDQo+PiBiZWZvcmUgYWRkX3dhaXRfcXVldWVfZXhjbHVzaXZlKCkgd2hpY2ggaW50cm9k
dWNlZCB0aGUgZm9sbG93aW5nIHJhY2U6DQo+PiANCj4+ICAgIENQVTEgICAgICAgICAgICAgICAg
ICAgICAgICAgICBDUFUyDQo+PiAgPT09PT09PT0gICAgICAgICAgICAgICAgICAgICAgID09PT09
PT09DQo+PiAgKGluIGF1ZGl0X2xvZ19zdGFydCgpKSAgICAgICAgIChpbiBrYXVkaXRkX3RocmVh
ZCgpKQ0KPj4gDQo+PiAgcXVldWUgaXMgZnVsbA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB3YWtlX3VwKCZhdWRpdF9iYWNrbG9nX3dhaXQpDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHdhaXRfZXZlbnRfZnJlZXphYmxlKCkNCj4+ICBhZGRfd2FpdF9xdWV1
ZV9leGNsdXNpdmUoKQ0KPj4gIC4uLg0KPj4gIHNjaGVkdWxlX3RpbWVvdXQoKQ0KPj4gDQo+PiBP
bmNlIHRoaXMgaGFwcGVucywgYm90aCBhdWRpdF9sb2dfc3RhcnQoKSBhbmQga2F1ZGl0ZF90aHJl
YWQoKSBjYW4gY2F1c2UNCj4+IGRlYWRsb2NrIGZvciB1cCB0byBiYWNrbG9nX3dhaXRfdGltZSB3
YWl0aW5nIGZvciBlYWNoIG90aGVyLiBUbyBwcmV2ZW50DQo+PiB0aGUgcmFjZSwgdGhpcyBwYXRj
aCBhZGRzIHF1ZXVlIGZ1bGwgY2hlY2sgYWZ0ZXINCj4+IHByZXBhcmVfdG9fd2FpdF9leGNsdXNp
dmUoKS4NCj4gDQo+IEhhdmUgeW91IHNlZW4gdGhpcyBvY2N1ciBpbiBwcmFjdGljZT8gIA0KDQpZ
ZXMsIHdlIGhpdCB0aGlzIGlzc3VlIG11bHRpcGxlIHRpbWVzLCB0aG91Z2ggaXTigJlzIHByZXR0
eSByYXJlIGFzIHlvdSBhcmUgbWVudGlvbmluZy4NCkluIG91ciBjYXNlLCBzc2hkIGdvdCBzdHVj
ayBpbiBhdWRpdF9sb2dfdXNlcl9tZXNzYWdlKCksIHdoaWNoIGNhdXNlZCBTU0ggY29ubmVjdGlv
bg0KdGltZW91dC4NCg0KRWlpY2hpDQoNCg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190E07012E4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 02:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbjEMAEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 20:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjEMAEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 20:04:06 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3623FC
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:04:02 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CMALUP012125
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=u90tXBD2bHz2/3Z7ynOteRSk3zAjkkGsa9YY5jkgw10=;
 b=indf3LxA/2qao+h6dgUypxTXjDYU4eV+OOdyPxIX4ofFt8uddIF6g7HqyOpCBt16TAvd
 IAhIvMjJawQJ/NWkfCqaT0IbrXwBu4ojeIkkGmAFO3BuNa7T2YhmscGJ/JL/yC2hHelZ
 FXI4OqQd8EEjdDjGlU1ct/pH5o6uQ6GG7C1tuvE+zKuahPme8Zkv72kv3hw9p99mrFe8
 xwEyb3C5DrrzHOeRQH1F4prbuFnFnzUEOcl0vvBRxckpaNMMHeaCdFUmglrTxbSKYduL
 SGXRncUljQ3pStHvkfOk7mi4sb2MFWaA5QwB5q85ZETtazDQRfA3mwbBeJU+2YugInuE 9w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qhaxbakj8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 17:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGWi+bY4wPSOhOrNTJOSWGn+EUL0m7EUpmTdiGKygjls53WCZJwmO451Ar2XoUQ+jKGk6WgNKQ57Kw/sdkR4gnspWjrb2dgnfH8R4zAqtMdAGIHJ9q1k58nnsNJIfVnEqpDFK5Vuh+brnHu8RU5ty7D3KTOsxKYD2yErbIu19bdMG2RT3EsCRxexCO3E367M3MONwVRPFzQw1W8jPoE5PG2qkKqJnuCHoCH9YoaDDAQ1LnLVSfLGy8ciW1AZN+tTPr1x2CL0biEI+9EinWGT0Nu5il97Ym8QOPD+pM5LK2hL2CGqaMMTxeBM759HFdC2+ju9iPYnQo/WLWRiYHAuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u90tXBD2bHz2/3Z7ynOteRSk3zAjkkGsa9YY5jkgw10=;
 b=Ktb20jTBvZe2WFucnwrGrkvs4CUdQ3zLw1ATS2JDrp71Ak5nY5N/EhUtnbeaHbtBzaOu5UkDn2T320eIdw57I4AnRr5Z0iJrcrtP5wPLXJtXqDAtsPkQkUNQI4CsoAyv+5Jk3z6lUySV8budvFDCrGYM21n9PYtRMix6PmXNJw130Cti+yZyNZvsgtt+he2Ol8LDc2ngfm5cd6uiv5H+GX2FqE9M2VSx3A0Cl/79yGVQBmPNe7aocsVocdBGQBaqjNHJsf3I/nweYQA3gRHgvOuxocbck7qMtXF69BZhre4sa8aOjqoccsoyrR2/z5nFcCiQLOf4ELiqR+05FKos0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DS7PR15MB5860.namprd15.prod.outlook.com (2603:10b6:8:ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Sat, 13 May
 2023 00:03:59 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e868:d4eb:382:e522%5]) with mapi id 15.20.6387.027; Sat, 13 May 2023
 00:03:58 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <song@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Topic: [PATCH] watchdog: Prefer use "ref-cycles" for NMI watchdog
Thread-Index: AQHZgsQGTR6REoP6vEGzK72DJVVZQK9XUNwAgAAGZAA=
Date:   Sat, 13 May 2023 00:03:58 +0000
Message-ID: <53D16C28-5489-4DFD-B8B3-6B20517A941D@fb.com>
References: <20230509221700.859865-1-song@kernel.org>
 <20230512164056.8f1e4e23032f7f7f5cb69df0@linux-foundation.org>
In-Reply-To: <20230512164056.8f1e4e23032f7f7f5cb69df0@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DS7PR15MB5860:EE_
x-ms-office365-filtering-correlation-id: c7397700-9cb4-46c4-dae0-08db53458d12
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TWxf44PNcsUTF89qi1anSS0jKwCxFaNzzWb0B3EUmSYY3xH7eOQgMzoAFhpoSh1bX8FSIX5k6vq+R08x4/SQCnt87tqSGJ46KBeo1o/9LpYJm0Z6qXjDe9iBlq7C6VZ5XHgOXqdCBwjVQI5rRc9x78SUYfepLsLvh09QswQWwtB2ELwKgR4l2ACrkEVn2so3hL4ERJ44q69QFd3M5+4aEuyfylZz5tF5UqI7xBez9Lk6KZG3wCbIEiNN0hrRU47A8pMDDYF6CTolbdNTIn7hsXgIEb1UxrSeCP3L/5MIESUlFQeQnvcrANjbfCGB7lRBhOurW3co4QGsH6NrjnpURsBvP5nMNs5jHYt3QOks39L5F8MeRuBZbrJqVi4ariJJwXZiLrSJ3r1FT7n/qTls7R3R0Swu9+S3urkfyUeiJoC5TfwbqpzCetPbEgCqr7VATWcp8eNTyMS8UVJq1uW5bHhSC3CHjICr8pJyKkWKCuVDIDIzFcgKDfqRMdbISf6JRdlzYMsmbCyAVX8GBNlIk3WGyxqKDrwellhIKFufe2BqHVZ+QJ2lG0xuyD5IMXrN0PcCEX4HkWStZrPA7gRpFm0Mae8uDv6yvFf39wQ6muK7LhR9grPkz9gK2N88Hmif
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(86362001)(83380400001)(76116006)(66476007)(66946007)(478600001)(66446008)(36756003)(316002)(8676002)(33656002)(8936002)(5660300002)(2906002)(91956017)(4326008)(64756008)(54906003)(6916009)(41300700001)(66556008)(71200400001)(6512007)(6506007)(53546011)(9686003)(6486002)(38100700002)(186003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mppq9V0zxh3EPYnLTK1wY1lQhR60iSAYYYXYE+y8f8V4VzR48j6ZThHyX9Fp?=
 =?us-ascii?Q?5O5+/OeqoK0pX6DoI41Khx2gC+O37s6oQuCayRZbBt0HDmcvDiRi2CU8JfYh?=
 =?us-ascii?Q?iUtOAxFhhNQ0dbkvCyC4koigDIHqh+9nXx1z4ItaHAQH6ayUPzdmBtxVP+uV?=
 =?us-ascii?Q?FDijg7mej8k7uAEJjNwRPVbYtDXEUJoira6UQztkmpWYkOHk6N66yC5T6V2p?=
 =?us-ascii?Q?ZW0yJUkSbglKquC/l/DAWspnVnqPAqmhXCKWLxAFwS72ww9SqB1iekUhs1W2?=
 =?us-ascii?Q?ESrKwKttZReq0JOCE7SCOwcW8LuhgiQyGK3L/kycAIJY7cbtLMszt1gVoWuy?=
 =?us-ascii?Q?kx+G2NsObeye7nlir3BbudZFwGNmRV5cbdv08TqTzgT6PsXGenT7rK5nIVGU?=
 =?us-ascii?Q?2ih5KUvuN+2sAwdZUmNgMKGfnM85RNVkmi/e04r2daAx+d7njOYfEpLUMqUR?=
 =?us-ascii?Q?4Tmk7ntk4+IdEvZR9OMvbxw2j/n6dXyCzDOjliNLe2QEHpkSYivBTquc01gi?=
 =?us-ascii?Q?T5BW9QCiTra4oDbn7XW6PXPsUsRZdSA4wf4RNW0bLkLsOoRvWGrXoWvI1MGF?=
 =?us-ascii?Q?8SDfvWvnhXdK0VV2+GOO2r8YyYYcH0wMEGhVUH7ir6Wlu7kfga7trZy5BV6y?=
 =?us-ascii?Q?5utEY4HJX4GaVMHLb+yoEoAMGa8zjPef/Ug4iYHYWircfjDx92qgaC+632tt?=
 =?us-ascii?Q?/HXewxeQCU8Mdr0lei3DY8jg+/Ix4vmlf6pcv0LIqb4fKrDiK+Ca7grA4StV?=
 =?us-ascii?Q?OR4TUuokRaaxpKun0EuvYZuVIqNDizauLsfIm9strRqkad9R4bAOcV9olhY1?=
 =?us-ascii?Q?yAc4yjizgg9uh17eLUIqjTQ2khJ7gwB4AYy/2hqCxCXDeXNADUTSN31tIOiA?=
 =?us-ascii?Q?ljJL1HXGoHqPu+2tSjbRlsMhbgGdo8zomsIsN+8bR4ayM7rGgxmKg4g2DY3o?=
 =?us-ascii?Q?Iz6v7G+FStRnqECbx5dchhIE9lX5v3TSiK7m2xke0Q0MkaeEFOv8/uHynEJe?=
 =?us-ascii?Q?C06LdjPibCKwsYciLgWf+3gr7sfj4ljhw7P752PmivpCf3uRNeSMb+smkP6D?=
 =?us-ascii?Q?/LLl+plIGl/arBulvvJjy/yMOZfEWOfO1a2g2Chc+hDDtPFPrtTSu03mt6as?=
 =?us-ascii?Q?B5i5a4NSIMCKksvct6OrHw2BUkkLNhIkUkS6gPyvvZeZHrgrfcQPzbcSTTU4?=
 =?us-ascii?Q?R+gAY+3G7Yn8/IHLPc++Oc4ChVyTmWk7WND8cAeU5SMyk5IYPT/YaQIbPG8W?=
 =?us-ascii?Q?i369L5riuzuroCDcIhePYZc+sXB2fqaeTNYg1uOp7INDjQNitIAyJgm23LN4?=
 =?us-ascii?Q?SLj89w44AbihTVFWmQZil3FGdHwQu4bz5frZq0uN8pYbemezMu59uF6ebhbq?=
 =?us-ascii?Q?dlVh/GRnQwgVkFdmc5dK5acnFzTXOLD/ydXxZVkyPLmXiZmyC3NdXT/QjEzK?=
 =?us-ascii?Q?PiLCIXB+pb560iJu0h+y2tuBnIqdnBqOC+WHeBQusnFHCTQSIDg5bAgKPEv5?=
 =?us-ascii?Q?B0CNIFnlWZPL9i+IAd3r7HRVEC5imJqwwl6E1Fm3JDMxsXLz6+R8O0hhkWv3?=
 =?us-ascii?Q?jUk1lKnzQjHoak30j2Tlfp8soFeI9f271iIg3hRv4JOzkIDK3joKrbxfznYq?=
 =?us-ascii?Q?/V1MAf/nX1TDl/8Y1IGOf5Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A91E00C91E0C95448256A6DCFB751138@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7397700-9cb4-46c4-dae0-08db53458d12
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 00:03:58.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d8gSaS44TRr7of73w0VL8TnoemHo8vPn46dGd7NlFIe4vs9oPMoXpR4pSynw9dVoDv/XeJWBdexpJOWzvhn15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR15MB5860
X-Proofpoint-ORIG-GUID: p_G2eUW5LEqSKmVQ8Gte1adYVSI41ikg
X-Proofpoint-GUID: p_G2eUW5LEqSKmVQ8Gte1adYVSI41ikg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_16,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 12, 2023, at 4:40 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> On Tue, 9 May 2023 15:17:00 -0700 Song Liu <song@kernel.org> wrote:
> 
>> NMI watchdog permanently consumes one hardware counters per CPU on the
>> system. For systems that use many hardware counters, this causes more
>> aggressive time multiplexing of perf events.
>> 
>> OTOH, some CPUs (mostly Intel) support "ref-cycles" event, which is rarely
>> used. Try use "ref-cycles" for the watchdog. If the CPU supports it, so
>> that one more hardware counter is available to the user. If the CPU doesn't
>> support "ref-cycles", fall back to "cycles".
>> 
>> The downside of this change is that users of "ref-cycles" need to disable
>> nmi_watchdog.
>> 
>> ...
>> 
>> @@ -286,6 +286,12 @@ int __init hardlockup_detector_perf_init(void)
>> {
>> int ret = hardlockup_detector_event_create();
>> 
>> + if (ret) {
> 
> If we get here, hardlockup_detector_event_create() has sent a scary
> pr_debug message.
> 
>> + /* Failed to create "ref-cycles", try "cycles" instead */
>> + wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
>> + ret = hardlockup_detector_event_create();
> 
> So it would be good to emit a followup message here telling users that
> things are OK.  Or tell the user we're retrying with a different
> counter, etc.

How about we ask hardlockup_detector_event_create() not to send pr_debug
message in the first try (something like below)?

Also, I think Peter's concern is valid. If some user daemon monitors 
ref-cycles in the background (I am not aware of such use cases though), 
this could be a real issue. 

Thanks,
Song


diff --git i/kernel/watchdog_hld.c w/kernel/watchdog_hld.c
index f77109d98641..a1d2a43ea31f 100644
--- i/kernel/watchdog_hld.c
+++ w/kernel/watchdog_hld.c
@@ -163,7 +163,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
        return;
 }

-static int hardlockup_detector_event_create(void)
+static int hardlockup_detector_event_create(bool send_warning)
 {
        unsigned int cpu = smp_processor_id();
        struct perf_event_attr *wd_attr;
@@ -176,8 +176,10 @@ static int hardlockup_detector_event_create(void)
        evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
                                               watchdog_overflow_callback, NULL);
        if (IS_ERR(evt)) {
-               pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
-                        PTR_ERR(evt));
+               if (send_warning) {
+                       pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
+                                PTR_ERR(evt));
+               }
                return PTR_ERR(evt);
        }
        this_cpu_write(watchdog_ev, evt);
@@ -189,7 +191,7 @@ static int hardlockup_detector_event_create(void)
  */
 void hardlockup_detector_perf_enable(void)
 {
-       if (hardlockup_detector_event_create())
+       if (hardlockup_detector_event_create(true))
                return;

        /* use original value for check */
@@ -284,12 +286,12 @@ void __init hardlockup_detector_perf_restart(void)
  */
 int __init hardlockup_detector_perf_init(void)
 {
-       int ret = hardlockup_detector_event_create();
+       int ret = hardlockup_detector_event_create(false);

        if (ret) {
                /* Failed to create "ref-cycles", try "cycles" instead */
                wd_hw_attr.config = PERF_COUNT_HW_CPU_CYCLES;
-               ret = hardlockup_detector_event_create();
+               ret = hardlockup_detector_event_create(true);
        }

        if (ret) {

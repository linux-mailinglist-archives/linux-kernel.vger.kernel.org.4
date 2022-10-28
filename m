Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FBC61179F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 18:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJ1Qhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiJ1QhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 12:37:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242AC1DF43E;
        Fri, 28 Oct 2022 09:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666975041; x=1698511041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZOUMeXKldrEmvp8OQ8UXIJA9ZZ6OmVW8Yq7tK/w2snc=;
  b=LUCDvm4gV+KBcJgyKSTHNFhKbikt8xhpO5fA1kyUPkP43t/A6rxCL4RS
   Fw91K7W0ukqxZQrz6GTw82z/xRNliSsRtByofePmLDPm6EXYUEgPPC4Mv
   AHs/YKV/fgljVEvL53vjOXT7CRPNBeWYPyNt5p3Ieb47n1cETIXs+Snsk
   jmX6u4NCzgGdpqcpvVeFWXHIdzaNOdCN/zHLiRj6tt4ES09LmFnsJEpgt
   DcaKicUEgvl93itFgs2Q41mLZVcYdbKy6Q6aeLaEZmkgUNYtkE/sJCZ9F
   9Zp3FkNRUa4gaL8yXqSiLvKK/SPscHKWBjB6ryQum9EvMlu+QVnfQS173
   A==;
X-IronPort-AV: E=Sophos;i="5.95,221,1661842800"; 
   d="scan'208";a="186729103"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Oct 2022 09:37:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 28 Oct 2022 09:37:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 28 Oct 2022 09:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYZXFWaJ8AHNN5NWizvnUaZWyeclfGjAC6Lr42s+LzZRfiJo2R8UaiYEdJDVu4/EaO3pi+thA8lbD9LnFvboweQxIe9ZIBKcaWy160HgqsHzg8rZnyzsEDAPCqcTimlpTM2C+Z5SA2LbR/y08EWLD/vmZLyHmDWIN40TsymXVj4IPrSrQ3s0wXVCODjs21QNv/RH1OJ2Aqglw1V2qlhBwpT8d/5sQvtG5Wt6Kbxmybtw0hrBtbKhlI1n8p4RiHNN+ZUSiqDzLZP0rjWqyfmpODzCFpa0wU5czvONPygyhU3ffGDIc0tjMNecNGNO8W9s/OpFXurv9nF3+VLBcT45sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOUMeXKldrEmvp8OQ8UXIJA9ZZ6OmVW8Yq7tK/w2snc=;
 b=etvgiVDEyJnz0yOq141GGuyak/ALfhX3Prc/ipoSyLL1nB0jXKfFmoPd+y/pBBtj8JUJUt//FqIjcDrptNhngZLpEo2JXOhShCdcEu2AWyctXIVEvk4SFHiPcmA8AIUOFN668aOKG6A6LE+5AUG79UgexU1dxWqD3cVy0eHjmX6TQpRSO10mnJcpjXo/G0zzz1500CJNFa02QDTwrN91l4YZhXfGGM+uFI/Et30TXwZLzqSH7KcjRICnQW6vKxuOc3RAKRFV2ZF0Dzo7kaz4cMH/jWsEhMM0gLtoBP0/pRxzAGfEdkHm9YCX3oi+T/J/3/JPcvam6IPBlsDWcfEzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOUMeXKldrEmvp8OQ8UXIJA9ZZ6OmVW8Yq7tK/w2snc=;
 b=H5IJaaWkPMxufg+l7Sxucc1T/SD+Vs5/2Cq+/DU5cub2b0L5wS5rojG6e0BEuS7KJHylny9/jS1+nMTa4SkuxPeIqOPIGEASa9v1ilcUD9WtgjvuQnFAWRIkualI8n9xUwODVV3/5OVMEb76f9dWaEA6u27DvQrXfDdwDDm9Y/k=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by MW4PR11MB6888.namprd11.prod.outlook.com (2603:10b6:303:22d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 16:37:18 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::1b9f:d534:5b73:892f%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 16:37:17 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <Terry.Bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bhelgaas@google.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>,
        <rrichter@amd.com>
Subject: RE: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Thread-Topic: [PATCH 0/5] cxl: Log downport PCIe AER and CXL RAS error
 information
Thread-Index: AQHY5X8sNi3OCqQh10eu9hrgsxOmFK4jw9EggAAkmQCAAB9VEA==
Date:   Fri, 28 Oct 2022 16:37:17 +0000
Message-ID: <MN2PR11MB3645EA7190EDD590035C834888329@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <20221021185615.605233-1-terry.bowman@amd.com>
 <MN2PR11MB3645681EA68D746AD5455DBF88329@MN2PR11MB3645.namprd11.prod.outlook.com>
 <b49d8871-d127-a296-4d0c-c89bb1ad7e1b@amd.com>
In-Reply-To: <b49d8871-d127-a296-4d0c-c89bb1ad7e1b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3645:EE_|MW4PR11MB6888:EE_
x-ms-office365-filtering-correlation-id: 37cf2aaa-ff14-4b4e-6849-08dab902ad24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6nqYako9R5OFtQSxLeyG75hiGsnwHu20VOJ1n+ELlM+2YXUBYHs04IWpCdgEoyqk8lf327sYuyK2xYIU2cxc2vgzatbvUdGPq2vuWA6BGIHn6oqZyxSrWBXgPGz2YJnjQlFTXuPMuHw+f+/bQ8BWFXV5FyKMhRf0BKRpXrsJBSvxBDKus2K7mOun1xQ62LdFTW0FJhiiKT/x7xZg/xLW8xVY0FAJjeVKWRERU/wju0QULCMD0v93fyt7PKPLtgV9QVD5WZCOC9mY2vMZjvpgtfP3BiIDmR5yIVHgo4GURl32YJ73m2nHvi6EZOhPNE+sEM3vNrijokx4+APmwnDbvMKsK+EqZri9dtDmNjS4CKHUq0772vA8I3vkD0uhuDCFc3Vkw0qqcrEv8kBl7vL2yI4ZF4WZoXlLAJnNDVqluBLdBPg0sAKHtPUa7gDIaGWBa07CrszuUvK3DpyNJcNkPtJ85xWmP3mrLV8Qb7MWGBgc1N3tgi0cTRKLYA2igAgX91KTOIMAxP8EdX9wEbwLWKD3z9Ck6FnpmMX1AknULWmTyCqCxnsEgORffYxWwtPsNjyfYRSgWWP8TQqzVUIXJzacjMdTIYvKKAcq/RervvonYMrtUGx5vyTVTziD77OnTR+x7++1GQw74piamUSH+vw/wOjs3+Cm6lqCWKitmtgMJPx5JikXpBCHsQJ+6HGZl0XuaO1EI9cfBH6Nrw4qH8oQRknEtWUDGpoy5rzCX85yl9ItTxfLRZ4xixMSkdyJZuZtn9Ff9ZeVatdpBm4EaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199015)(33656002)(86362001)(83380400001)(122000001)(8936002)(38100700002)(38070700005)(5660300002)(7416002)(2906002)(4326008)(66556008)(66476007)(66446008)(64756008)(8676002)(41300700001)(52536014)(66946007)(6506007)(186003)(7696005)(26005)(9686003)(53546011)(54906003)(316002)(76116006)(110136005)(71200400001)(478600001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zzk0SWVUNFd1MU11UmlrMDRCRFB5OFRIV3FVSy85ZGFmVGNRLzhjUDJ5S282?=
 =?utf-8?B?a2J1YVdpeDh5cGNZeFN2dHVJY1lCYkRGOTlodTJmMFR2MGdob3N5RUNaTzVw?=
 =?utf-8?B?cWJYWnNWcjYyL1lBbG84Q2lhWFYxdStNRFNxMXcrQkRMb3p4aDJqUVNRTTZT?=
 =?utf-8?B?b0N2K1d5aTNGWS8vZzg4aWwrRmw0a1pBNnE5M0xlRm5JeWhkdXB0bXpZLytB?=
 =?utf-8?B?bElxakxzWVBkMDJYQ2NGaXBwS0ZWUHZMT0V4RGREUFRwblU0eWZnYWN1Yzhl?=
 =?utf-8?B?djNvMGtmdmVkWkcrZFJ4Y21YdFpzQ3dhREdUUkNlbXBMV0Q2ZEJvVk40aGdk?=
 =?utf-8?B?YldHUytnT0s0VTFXYXhXUTlXY0lKNmdPei9leWxPbTFQTVVNa3pURkFkUzhQ?=
 =?utf-8?B?WlQ5amIwcUlhYVRualhBcWlVbUhsK3g1bFN0YVcvWE5xbkh1SFlkaUxHYnhl?=
 =?utf-8?B?eWxXRmRHc3hUSmFlOWFkNmd3bC9uV2JMZnB3OGZuZGNhek9SSEtmZHlZbk1z?=
 =?utf-8?B?N0crTGh3OEFDU3dSL0lWOHh4VEJocUdMYzhZMkxBWE42Y2tWR2tXU3B2QkFF?=
 =?utf-8?B?bXNONDA0dTZUQmMyUFJSNFVZL2REKzc0T1dCQXpRbUdnMExQQlZzbEZBRHAw?=
 =?utf-8?B?Z1ZVOC9xWVRwZkptelBKempuOExjUnpNZVg5bnR3QzliYk4wS3YyTjkwc3Za?=
 =?utf-8?B?dzJMcjAzMndLbHhLSmhsdTN2ckc3MTIraERFOU95bk1vMEZwWFNHRUt5K1Ry?=
 =?utf-8?B?cDN6YllsVkNyaGw0OEVnekorVUowOGNrNlMzN0tGWnRKRzByd21FUlNNbk1R?=
 =?utf-8?B?SGJZUFVBQ1ZQT25RVjUrWXpmbWYrdXBRWXM0NkRSYXFTN2QvQmxBQUdqYlpz?=
 =?utf-8?B?dEpzK0lVOG1QY0FQdGJSY2s5ZUtRMDlWemZrdlRENXpLZ1RnVzRTeWtvb0lr?=
 =?utf-8?B?OG1TZFJLVVpkUmw3eFAvY2dkOUY4QXVwVzBxMjZaVllreSsrK1p2ZVhxQWU3?=
 =?utf-8?B?WEMzcTlxLzhtcXNoYnJZVDkvdnhnNFZVNHJkNlVra0ZCbS9zUUVLNytoUElV?=
 =?utf-8?B?REpRdFkvTld5SlEzUHFaODRMZU9aYnVBL0I0d3FlT0Jhd0hVc3JKRVptSVU5?=
 =?utf-8?B?T0pTQ0VRTDZyR0YyVUU4cmRka3FjMmdXb01idTV4WldPWk5sNHlpeFQzL3pK?=
 =?utf-8?B?L0MzZldUendGTGpkRlY4L2xMa0p5QUhGLytpT1pHREhXWTREVW1FQWVjYWtI?=
 =?utf-8?B?RnB6bXJ5RkhOdnRQSzNhZlpDVWJGN1JKWUFHSzRDd016dnBhTjIweGt4REh6?=
 =?utf-8?B?N2JORWpEck1vNWxOYUpnYkNkbnU5UzhZYnZtSkppTk9Zak9jelg5bDBDREdq?=
 =?utf-8?B?Q2JEYUx0ZEtOb0lNOFc3VnphUkxqVjlTSllRMXR5M0N4SUhLdlFtM1ZQRlBE?=
 =?utf-8?B?RVBjMlNVb1ZpUm9hQTFVRjhwNC83UmpiWlBrdXVacU5QUjExOWI0NXgyQUY5?=
 =?utf-8?B?TlRJZXRrNC81WUIyUHJlQi95TkpYOU56elFTM1ZBZGtZM0piT3YyTkRtNkxX?=
 =?utf-8?B?UnhSSkY0VXRqZWhybEUvOEJnUllrWEZuai9xaXBkcnFsdGtUcVZ3ZTFXWnFK?=
 =?utf-8?B?aldvUVJQZFJjMFZLK1FYYW1YZTVuYjQ3Nm9NZkZTeTBCZWx1Mjg4UzNPZ0VF?=
 =?utf-8?B?eUJiaUg0eUlSOW1pSytxcTBqMGg1TUVWYW9GQjNvTHlNcXdVRFBiSzZoMkti?=
 =?utf-8?B?VmpIbkxIeE5uZDFFMUJNbWNZd0Z4bVVOaDFFa2psdHdQakZKY1JMOHNvNVJY?=
 =?utf-8?B?SWVEYUtLODJ3THFLVnUvN0NUeFphcHJwQ0V6S2lvRGVHQi9hTnFxdUtlbEFT?=
 =?utf-8?B?aWhJZzlIeFpmc1lBSkI0a2JzU1g4T0gzWDQ1MUc0U3Q5Z01yNG85WlJEY2xH?=
 =?utf-8?B?THU3a0Q3SlNCRlNleFNsK1hjR2o2cWFHaDhzbURLaWtJZWt0ZXl6ZHduNzNU?=
 =?utf-8?B?R1B3U2NiODBpUm5WcUVtQVJvT0RwbjNPV3N5ZXpzbExqWk1ZcGNoeUhKNDk0?=
 =?utf-8?B?VnlSOXFuT21CQWFOVnJiaDdhc0JFM0IwME5Yd0pYdzYyYnA0VlB5ZTJxdVpm?=
 =?utf-8?Q?EorwjExcldkVBDS8UhSdYAOEI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37cf2aaa-ff14-4b4e-6849-08dab902ad24
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 16:37:17.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTMWS6HCDDePPyvuX6/YRKBiuYQaaakB+ZzF+U2NL2CKHuicSS8iXVOnbRLqUma+fELZRj7mANNSJaGTrf1e3VqM2sZjS1sGeyCHFM7TCwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6888
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUZXJyeSBCb3dtYW4gPFRlcnJ5
LkJvd21hbkBhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjgsIDIwMjIgMTE6MzAg
QU0NCj4gVG86IEFyaWVsIFNpYmxleSAtIEMzMzM3MSA8QXJpZWwuU2libGV5QG1pY3JvY2hpcC5j
b20+OyBhbGlzb24uc2Nob2ZpZWxkQGludGVsLmNvbTsNCj4gdmlzaGFsLmwudmVybWFAaW50ZWwu
Y29tOyBkYXZlLmppYW5nQGludGVsLmNvbTsgaXJhLndlaW55QGludGVsLmNvbTsgYndpZGF3c2tA
a2VybmVsLm9yZzsNCj4gZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tDQo+IENjOiBsaW51eC1jeGxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bn
b29nbGUuY29tOyByYWZhZWxAa2VybmVsLm9yZzsNCj4gbGVuYkBrZXJuZWwub3JnOyBKb25hdGhh
bi5DYW1lcm9uQGh1YXdlaS5jb207IGRhdmVAc3Rnb2xhYnMubmV0OyBycmljaHRlckBhbWQuY29t
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC81XSBjeGw6IExvZyBkb3ducG9ydCBQQ0llIEFFUiBh
bmQgQ1hMIFJBUyBlcnJvciBpbmZvcm1hdGlvbg0KPiANCj4gRVhURVJOQUwgRU1BSUw6IERvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlDQo+IA0KPiBIaSBBcmllbCwNCj4gDQo+IE9uIDEwLzI4LzIyIDA3OjMwLCBB
cmllbC5TaWJsZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPj4gRnJvbTogVGVycnkgQm93bWFuIDx0ZXJyeS5ib3dtYW5AYW1kLmNvbT4N
Cj4gPj4gU2VudDogRnJpZGF5LCBPY3RvYmVyIDIxLCAyMDIyIDM6NTYgUE0NCj4gPj4gVG86IGFs
aXNvbi5zY2hvZmllbGRAaW50ZWwuY29tOyB2aXNoYWwubC52ZXJtYUBpbnRlbC5jb207IGRhdmUu
amlhbmdAaW50ZWwuY29tOyBpcmEud2VpbnlAaW50ZWwuY29tOw0KPiA+PiBid2lkYXdza0BrZXJu
ZWwub3JnOyBkYW4uai53aWxsaWFtc0BpbnRlbC5jb20NCj4gPj4gQ2M6IHRlcnJ5LmJvd21hbkBh
bWQuY29tOyBsaW51eC1jeGxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+PiByYWZhZWxAa2VybmVsLm9yZzsgbGVu
YkBrZXJuZWwub3JnOyBKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb207IGRhdmVAc3Rnb2xhYnMu
bmV0OyBycmljaHRlckBhbWQuY29tDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAwLzVdIGN4bDogTG9n
IGRvd25wb3J0IFBDSWUgQUVSIGFuZCBDWEwgUkFTIGVycm9yIGluZm9ybWF0aW9uDQo+ID4+DQo+
ID4+IFRoaXMgcGF0Y2hzZXQgYWRkcyBDWEwgZG93bnBvcnQgUENJIEFFUiBhbmQgQ1hMIFJBUyBs
b2dnaW5nIHRvIHRoZSBDWEwNCj4gPj4gZXJyb3IgaGFuZGxpbmcuIFRoaXMgaXMgbmVjZXNzYXJ5
IGZvciBjb21tdW5pY2F0aW5nIENYTCBIVyBpc3N1ZXMgdG8gdXNlcnMuDQo+ID4+IFRoZSBpbmNs
dWRlZCBwYXRjaGVzIGZpbmQgYW5kIGNhY2hlIHBvaW50ZXJzIHRvIHRoZSBBRVIgYW5kIENYTCBS
QVMgUENJZQ0KPiA+PiBjYXBhYmlsaXR5IHN0cnVjdHVyZXMuIFRoZSBjYWNoZWQgcG9pbnRlcnMg
YXJlIHRoZW4gdXNlZCB0byBkaXNwbGF5IHRoZQ0KPiA+PiBlcnJvciBpbmZvcm1hdGlvbiBpbiBh
IGxhdGVyIHBhdGNoLiBUaGVzZSBjaGFuZ2VzIGZvbGxvdyB0aGUgQ1hMDQo+ID4+IHNwZWNpZmlj
YXRpb24sIENoYXB0ZXIgOCAnQ29udHJvbCBhbmQgU3RhdHVzIFJlZ2lzdGVycycuWzFdDQo+ID4+
DQo+ID4+IFRoZSBmaXJzdCBwYXRjaCBlbmFibGVzIENYTDEuMSBSQ0Qgc3VwcG9ydCB0aHJvdWdo
IHRoZSBBQ1BJIF9PU0Mgc3VwcG9ydA0KPiA+PiBtZXRob2QuDQo+ID4+DQo+ID4+IFRoZSAybmQg
YW5kIDNyZCBwYXRjaGVzIGZpbmQgYW5kIG1hcCBQQ0llIEFFUiBhbmQgQ1hMIFJBUyBjYXBhYmls
aXRpZXMuDQo+ID4+DQo+ID4+IFRoZSA0dGggcGF0Y2ggZW5hYmxlcyBBRVIgZXJyb3IgcmVwb3J0
aW5nLg0KPiA+Pg0KPiA+PiBUaGUgNXRoIHBhdGNoIGFkZHMgZnVuY3Rpb25hbGl0eSB0byBsb2cg
dGhlIFBDSWUgQUVSIGFuZCBSQVMgY2FwYWJpbGl0aWVzLg0KPiA+Pg0KPiA+PiBUT0RPIHdvcmsg
cmVtYWlucyB0byBjb25zb2xpZGF0ZSB0aGUgSERNIGFuZCBDWEwgUkFTIHJlZ2lzdGVyIG1hcHBp
bmcNCj4gPj4gKHBhdGNoIzMpLiBUaGUgY3VycmVudCBDWEwgUkFTIHJlZ2lzdGVyIG1hcHBpbmcg
d2lsbCBiZSByZXBsYWNlZCB0byByZXVzZQ0KPiA+PiBjeGxfcHJvYmVfY29tcG9uZW50X3JlZ3Mo
KSBmdW5jdGlvbiBhcyBEYXZpZCBKaWFuZyBhbmQgQWxpc29uIFNjaG9maWVsZA0KPiA+PiB1cHN0
cmVhbWVkLiBTaG91bGQgdGhlIHNhbWUgYmUgZG9uZSBmb3IgdGhlIEFFUiByZWdpc3RlcnMgKHBh
dGNoIzIpPyBUaGUNCj4gPj4gQUVSIHJlZ2lzdGVycyBhcmUgbm90IGluIHRoZSBjb21wb25lbnQg
cmVnaXN0ZXIgYmxvY2sgYnV0IGFyZSBpbnN0ZWFkIGluDQo+ID4+IHRoZSBkb3ducG9ydCBhbmQg
dXBwb3J0IChSQ1JCKS4NCj4gPg0KPiA+IFRoZSBSQ0QncyBBRVIgcmVnaXN0ZXJzIGFyZSBub3Qg
aW4gZWl0aGVyIHRoZSBjb21wb25lbnQgcmVnaXN0ZXIgYmxvY2sgb3INCj4gPiBSQ1JCLiBUaGV5
IGFyZSBpbiB0aGUgUkNpRVAgY29uZmlnIHNwYWNlLg0KPiA+DQo+ID4gUGVyIENYTCAzLjAgU2Vj
dGlvbiAxMi4yLjEuMiBSQ0QgVXBzdHJlYW0gUG9ydC1kZXRlY3RlZCBFcnJvcnM6DQo+ID4gIjIu
IFVwc3RyZWFtIFBvcnQgUkNSQiBzaGFsbCBub3QgaW1wbGVtZW50IHRoZSBBRVIgRXh0ZW5kZWQg
Q2FwYWJpbGl0eS4iDQo+ID4gLi4uDQo+ID4gIjQuIENYTC5pbyBGdW5jdGlvbnMgbG9nIHRoZSBy
ZWNlaXZlZCBtZXNzYWdlIGluIHRoZWlyIHJlc3BlY3RpdmUgQUVSIEV4dGVuZGVkDQo+ID4gQ2Fw
YWJpbGl0eS4iDQo+ID4NCj4gDQo+IEkgYmFzZWQgdGhpcyBjb21tZW50IG9uIENYTDMuMCA4LjIu
MS4xICJSQ0ggRG93bnN0cmVhbSBQb3J0IFJDUkIiOg0KPiANCj4gIlRoZSBSQ0ggRG93bnN0cmVh
bSBQb3J0IFJDUkIgaXMgYSA0LUtCIG1lbW9yeSByZWdpb24gdGhhdCBjb250YWlucw0KPiByZWdp
c3RlcnMgYmFzZWQgdXBvbiB0aGUgUENJZS1kZWZpbmVkIHJlZ2lzdGVycyBmb3IgYSByb290IHBv
cnQuLi4gVGhlDQo+IFJDSCBEb3duc3RyZWFtIFBvcnQgc3VwcG9ydGVkIFBDSWUgY2FwYWJpbGl0
aWVzIGFuZCBleHRlbmRlZA0KPiBjYXBhYmlsaXRpZXMgYXJlIGxpc3RlZCBpbiBUYWJsZSA4LTE4
Ig0KPiANCj4gQW5kIFRhYmxlIDgtMTggaW5jbHVkZXMgJ0FkdmFuY2VkIEVycm9yIFJlcG9ydGlu
Zw0KPiBFeHRlbmRlZCBDYXBhYmlsaXR5JyB3aXRoIG5vIGV4Y2VwdGlvbnMuDQo+IA0KPiBUaGUg
UkNEIHVwc3RyZWFtIHBvcnQgbmVlZHMgdG8gYmUgcmVtb3ZlZCBmcm9tIG15IGNvbW1lbnQuIFRo
YW5rIHlvdSBmb3INCj4gcG9pbnRpbmcgdGhhdCBvdXQuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhl
IFJDSCBkb3duc3RyZWFtIHBvcnQgZG9lcw0KPiBpbmNsdWRlIHRoZSBBRVIgcmVnaXN0ZXJzLg0K
PiANCj4gUmVnYXJkcywNCj4gVGVycnkNCj4gDQoNClRoYW5rcyBUZXJyeS4gWWVzLCB0aGUgUkNI
IGRvd25zdHJlYW0gcG9ydCBSQ1JCIG11c3QgY29udGFpbiBBRVIgcmVnaXN0ZXJzDQpkdWUgdG8g
dGhpcyB0ZXh0IGluIENYTCAzLjAgU2VjdGlvbiAxMi4yLjEuMSBSQ0ggRG93bnN0cmVhbSBQb3J0
LWRldGVjdGVkIEVycm9yczoNCiIxLiBEUEEgQ1hMLmlvLWRldGVjdGVkIGVycm9ycyBhcmUgbG9n
Z2VkIGluIHRoZSBsb2NhbCBBRVIgRXh0ZW5kZWQgQ2FwYWJpbGl0eQ0KaW4gRFBBIFJDUkIuIFNv
ZnR3YXJlIG11c3QgZW5zdXJlIHRoYXQgdGhlIFJvb3QgUG9ydCBDb250cm9sIHJlZ2lzdGVyIGlu
IHRoZQ0KRFBBIEFFUiBFeHRlbmRlZCBDYXBhYmlsaXR5IGFyZSBub3QgY29uZmlndXJlZCB0byBn
ZW5lcmF0ZSBpbnRlcnJ1cHRzLiINCg0KSG93ZXZlciwgdGhlIHRleHQgaW4gdGhlIEV4Y2VwdGlv
bnMgY29sdW1uIGluIFRhYmxlIDgtMTggZm9yIEFFUiBpcyAiTi9BLiBTb2Z0d2FyZQ0Kc2hvdWxk
IGlnbm9yZS4iLCB3aGljaCBJIGZpbmQgc29tZXdoYXQgY29uZnVzaW5nIGdpdmVuIHRoZSB0ZXh0
IGluIFNlY3Rpb24NCjEyLjIuMS4xLiBIb3dldmVyLCBzaW5jZSB0aGUgdGV4dCBpbiAxMi4yLjEu
MSBpcyBleHBsaWNpdCwgdGhlIEFFUiByZWdpc3RlcnMNCm11c3QgYmUgdGhlcmUuDQo=

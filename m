Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB86C73D5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 00:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjCWXCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 19:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjCWXCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 19:02:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192DB75A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 16:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679612536; x=1711148536;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MY2q9CA3LHHEbcfejl1V5Md74tv8xyRMwGfqvrB7Q4o=;
  b=apZVSfvaeq7Gj+s6o63uvfXJAuIShKjzAmJjX7vC38TG4IoVWFmOn/2j
   7SzivlDAPOubSDvRJ9vRS4GkyzpqgTC3ZVz+DeqZPEEn32efevCnhjcIV
   6Nz1q5hyWdXDKLT+fC7mcTrlJ6P3liypYXi4BMG1kW+gX4/EklytPaoy5
   dEZIwBjI1FHhMq0ExV3MD6s/QEKucTtUrqTtZWJ/XeocXkxvBA9Sw4Br5
   v62hWPaM1+AVf6FxB/tNASBcegI4K9syF1mLRT95UG6erMnhR182eT/+/
   GwSHcgCNNNZY6byyYL9MuvBvyrK1PTIjL5I0QITo6q7Y7d4oD62ZIl/HQ
   A==;
X-IronPort-AV: E=Sophos;i="5.98,286,1673884800"; 
   d="scan'208";a="226371729"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2023 07:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ/BrbwlMQqnK7nkYPsKxcLGttgR4JzHFJbA6MOsoB1RcC4kwgCB8pWVvZ7bsxN6fjqyr51QTwKm1ncCaTzJ+Me5IpPxtKtaUBc+X8zdmVPljNsoEpdpIS7omKTe48/S/Xr0d4Bj2WNQdl22RNyNSHb5/nH38RjD0+q6vp6DqidfHXM0xmqHxpaFllavCjFnA6+Hh8s2lwOCI68d8SUDeS8hMfG4O32U5dLfHJrwf1c5/kEcqzfBdflnkO4gAJ35J9cZfHzw8wfB7ess4kEpyG3k9WK9ikBpjKO7f8UnG+Pu7kjvYhWFk0PcJRMAjx5vOfyR6ObiXbj/IE+SD7Y2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MY2q9CA3LHHEbcfejl1V5Md74tv8xyRMwGfqvrB7Q4o=;
 b=SJ7q9JtMsR6T6LXni2RYa2Rw6T7QQsqTiuWJZVCXoo0up0uFMk5vD9CgauNwawOe9AMHcu0odpysvF5K0Xl4bds1bwCaGQuSYEiQJWcUhba517iiyx8KZFjBccE3kBcv3dAwJ81twcuJLvYMVIVoTqRb2Xc1vJ/gGGGdiIuBTpoLZh1zryQ9eHwN7wqiAgTr42Ub6eCRkNxDpZwABzdhcFP08FGLqfFaa2buXrUoU51uGD2geSW+SXvjbW2Mgw563lQ+VRROkhNWDXQgJcA3fxXXM2NCeIAXorbMdbcUrRCAhPkWVd/yThJavNqoyCN+NZPxGJowBaKnJtls1PHbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MY2q9CA3LHHEbcfejl1V5Md74tv8xyRMwGfqvrB7Q4o=;
 b=DMQe0sHpC9+oSgMG+SMVEeYVlXEtKndqBE6yRpkIwzkn3L+dUHZD8QvLB+g6ZAgCX2/+B/IEd2rUK0eCQ34YqknKR8qygWZCLsrivUD/LCLx+EU0uKaDfhdm21EkIGFXwvQEcCtYsh12GPq0DW7KxCeuU1zs8baTdiKenssQr+k=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 23:02:13 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::b6bd:9281:f8bb:f22a]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::b6bd:9281:f8bb:f22a%9]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 23:02:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "hans@owltronix.com" <hans@owltronix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        "chao@kernel.org" <chao@kernel.org>
Subject: Re: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Thread-Topic: [RFC PATCH] f2fs: preserve direct write semantics when buffering
 is forced
Thread-Index: AQHZRSW5shjzpCUo40u+8cmEhE3wt68D2TwAgAVGSICAAA0kgA==
Date:   Thu, 23 Mar 2023 23:02:12 +0000
Message-ID: <402cc90ce5defa81c937c3fcd09de1f6497459ee.camel@wdc.com>
References: <20230220122004.26555-1-hans.holmberg@wdc.com>
         <ZBhisCo7gTitmKeO@infradead.org> <ZBzPYwcoLXkFngz8@google.com>
In-Reply-To: <ZBzPYwcoLXkFngz8@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB7081:EE_|BY5PR04MB6327:EE_
x-ms-office365-filtering-correlation-id: fdb4a0fc-28a7-40ac-f416-08db2bf2a367
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GM5Ry6L5JlmFrQQNf0sGul4VjsFS2md5UJU4XtQPblqHZV/p2cv/CD9C1qGKLTdtweXZ1/eSB7Kr+MaYABl5XE5ogYBmtyAA0KWAIavksGoEPDlYBwAVLJ2za2jiOzdPRJttd42Ptm3xQVEoGFCn4y3+lXnO5FsgUwoLAzFAY9P86WBS6uy8eoNTMCLmcZfeuwleX3WQQjynS85QSvbB3pzPhPX34R0xV5FPx9u1PhOvJ/SJCeETZq9V3SBgC9ZCoILncTiuqPZUYrT91bj3mhGwpQoVDrPCpWDP8xOCIQX0DNV42kOmWNpLoAlCribuBtn86IBtl/O9tK9HLEewcYHETL15PdJz9+T9Dkxx10qO0X1hm+v2MEdyWDthULq4ZGnx2mhj2CbUoNFuAv7qfXFRN9sRjq9TYoS2tGclpyPqlGTWAt7MM8/VNtBD1ekhFhY5NC/LCCAYW6pyQePABnCEjEC2F6I+Vl9zviXB3//TKpzDmZrwL5UIgOjD6ijC4ndlpXmPVDUxbcXCGs0MiubZtcA7eYnDjjWUxc7aE6PrnIXLu3lDmS+vdSPxJbJVgCNqVxStgydhofn/ytw1B7fYV45NiiK77/MRNUWuczIjuvvH8Nbx9DVUj+L6OvjJZgeM67ooSY+s4tXdFzePlyZHTeDIwkwVWfUo3NyJQ7Uu9y5nC7L459BaojiPxcHjfs/vtIRutozcZAYlTQXUdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199018)(36756003)(38100700002)(76116006)(8936002)(4326008)(8676002)(86362001)(66556008)(91956017)(66946007)(66476007)(66446008)(64756008)(41300700001)(54906003)(110136005)(71200400001)(478600001)(6486002)(316002)(2906002)(4744005)(5660300002)(82960400001)(26005)(6512007)(122000001)(38070700005)(6506007)(83380400001)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WENLc2pUNFcrMFJmWHJDL1FFNlZWNmhGemtCbEZzaHg2TllNVmNKblRrbndh?=
 =?utf-8?B?bHNuUEpiNURDY0xyUEwxaXpzTWNjcVVjQjRsNVRYRWFUY0VLMUFqekIwREVV?=
 =?utf-8?B?NUppSDNJREgvSllEeEFHaU5KaDZyeTk4M3N3aEkxdHdqNFp0eDRsdWRJZmJC?=
 =?utf-8?B?Ym1yRHBlUnpVTHhvcjZwOXgxVzNpcGlFbzcvYmQ0eUlqV3l5cFUvWU5NVU11?=
 =?utf-8?B?ZGU1bllZQ042YXNlQWJVc2FtVkZwbnpBWW92dVhSbnpSUXM0TzFndVNQY2x4?=
 =?utf-8?B?YTBaMWxoa0RXQ21XZjBCeXliclJFb2o3SXFrSDl1YkRHajgxd3h0S3RaUHpt?=
 =?utf-8?B?L3pPYUJDNHJvcXg5WTdCSHh2WitWNWh4aFlkNk9vTU1ta3RTMjErM0J1ZVBs?=
 =?utf-8?B?SjhzVm53RkE0VVU0alh1c3Fib1NndlNpYVlXRkI4TU9pWFVEYzV2SGtib1RT?=
 =?utf-8?B?V1M3ZHpoNUUvUm8vVmJ0ckFGSnViSkNsdmFxRkVqdmt2NWRVVm5TQXQ2Y3VP?=
 =?utf-8?B?c2R5TDhyWWVTYisyTVRKbnIvbE9hVGxEUC84Mml2VDlXSlJmdTk4dDNuOTZU?=
 =?utf-8?B?c2JzZ1dTcGJKV3RRVm5DNE1EeC9YZGpqYXhEUzZ6SERleWhQTzQrbG94cDBj?=
 =?utf-8?B?UXQ5TDdvVVp1MVNnMStia281QTZxR08wSk1paXpMZVhKd2pUWUtLUjdmdU5K?=
 =?utf-8?B?MFZ5SVdnZDZrY3ltRGlwY05NZDF2dERRWkpnKyszNVFSYmlsZFBQOWsyN09i?=
 =?utf-8?B?MzlkeWZvNmhXK0FsSUNYZHFDeXdOemxRdDZmQmlrZ2YraEJyK1gzMk4yZjkw?=
 =?utf-8?B?WC9maDlCeWRyVzhtRDNyV2VKUFBXZ1V6ZWhqOVV5clI4dXNyclpyU3FKaXpo?=
 =?utf-8?B?c0g1eklYSEc3dWxxdFM4WXVJZ0M0RUp0RnFCUzY5QWV4Zk40c2NCRmNXR21w?=
 =?utf-8?B?L0dwSUxiSDh4S2JHTnVlVG4vTzJkTlpVdWo5S01uSGJWSVA3L1VKVFBacEV1?=
 =?utf-8?B?bXQ5VU9uYi9zbEhuOHk5bVNzUzhMcWtNYVdFR21rcnRpNEtpc3ZQYVpGWlFW?=
 =?utf-8?B?dXJ5dlBvZElIUTczMkNoM0hGSXZhelFoTGM4a3JqVVZ0Y3RjVUlKd0ZhQ0RB?=
 =?utf-8?B?ZHhEbW9HbERlamQvallYcjdSM1dPbE10bklURTdtZ3dPRE5LTDR2QnVSWS9D?=
 =?utf-8?B?b05DajQ2TjAyazl6LzV0RHJNOGVZSDFxQjBVcUliYVZtNTRuQ2RuRnVNSUFJ?=
 =?utf-8?B?aTk1UThwV1djdDE0cVZiYnNQZDY1VmRnME9TanRjbElTdkIzZ2c4MmUyMzlt?=
 =?utf-8?B?S1FCQ1BOd1pxZFJDc3g2TXpTajJFaG1Vczd2ajIrUFlGMzMweGZVTWdUVXRG?=
 =?utf-8?B?ZnZISkJpUkFOV1RmcDBuRGxWNnU5NmNHOEI4TUFGQlNMV0JiNDZqNkZKZ0Q0?=
 =?utf-8?B?RW1aNTlpMmtoV0NWOWs3bVVyMnlGdXdKMjA3RHpSeGd6N3pRTmlqYjQ0TWl5?=
 =?utf-8?B?Tjd4TVVFeWo0VC9vZFRaNlptWFZqSU1SQUl4bnBWZjdCV0tpaktmSytNY28y?=
 =?utf-8?B?UmpOK0ZTdXRaNFFtNStnZm94UWZpTGh0ZFE0dVYxYlljTnVuVE0xVVQ2QndR?=
 =?utf-8?B?YjZ4Uk1DZnZDTmRkZk9DRXQ0b3VtQzM0T282N0I0dUVMUDRXMUp6dUNYSU5x?=
 =?utf-8?B?RjJneEhNSklRVEczVDBpZ2dkTjJ5UWZXSFJuRktTSVUxWHlQSCsvMzZzZlBu?=
 =?utf-8?B?VmhQdmhMbmJQMUxFeThsYkNnSTJ1TTJ6endsUWcwa25MY2l2YnhzMFRsRWdR?=
 =?utf-8?B?RlJ3WHdyL0V1N0dpU1JGdmpkQUNpYmNLUm8zYVVyMTdGT2JqeE1zcWU5b2lh?=
 =?utf-8?B?bDdYMVdxeXdvL2dZU2M1TU9sRTFtSXRrOXRZNEJNRTdBL3ZMS3lxU3FhcmhK?=
 =?utf-8?B?U0RmVzhDN0M5QWF4U0YxNjF5cy90UlRRd0RXUHpxYmNQYTE0QWFxUnZGSTh5?=
 =?utf-8?B?bzdMNWtkcGhGbm41YjhEN3pBY0swVTYwa1hxUnhLeUovZFR4MU5CVjFNVUlC?=
 =?utf-8?B?VGdmVCsvRmtlOWtsdkhlTUczK1JjWmQzNXFmM2xZTzl1MytkRXNnV1VFMDJx?=
 =?utf-8?B?c1lWaEw1cTkwcEYvSWF6OFY0MnVuamxnN2IwN1c2RkR2TTc3SmJ4dUpVS0lG?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2AFB4649F411F4A8B92B9108BA1982D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUNlZnpOZHFaL281S05BbWhST3U1TnI5aEwrM050bjBMbkwzMitHOTd0N0VX?=
 =?utf-8?B?dTZURTgyRld2bnFmajY1VkhYbFlnSkpvSUNmaTU2N1FjenhTTEMzQ09jYWJr?=
 =?utf-8?B?elY3MG9kdkg0UnVyT0h0TldGSWZoWStjQVBTWmJHK2daRmJrc3gyWXFFSUhD?=
 =?utf-8?B?NUhXdmszc0RSdytFMll2WkRoZTdKWjVSV2UydzRPd2xMUHRFZmJoMVdnczM2?=
 =?utf-8?B?cnpLZytxdjFxUWJSK0NnV1lEYXpwWG85MVBnTWVwdERKVWozM3VJNDlyQjZx?=
 =?utf-8?B?ZENEd0pZc0pHamZaMHNMN3ZIYnYxRXZGUERqcVhBTlVzQlJpbUNFMWRPM0Yv?=
 =?utf-8?B?dC9WbXorQUY3Q3poNkxZVFFBWTkvdU9mME5Xci9sZnhnZmFLY2JGdXZlZThI?=
 =?utf-8?B?eEN1YWV1Y3NvNENpOWtFTlpzRjZpemhHdFBqVDV6bC9ZczV5TkhGdDhVV1dW?=
 =?utf-8?B?OUovRVpEQzY3VVVjemRobG85aThodmJVVi9PMG5qQUNsRm44TWE0U0F1MUdX?=
 =?utf-8?B?TWNQSDFoNHBZYnFRSUxBMGZsdFNIcXBLTkhQc0pPdkpONS8ydUNIckd3b2xr?=
 =?utf-8?B?dWVuV0N4V2x2SFpZbGx3bWhFWHhaVjhyQ0NzVVVZRlAyZGZuOTV5SGhOU1Rp?=
 =?utf-8?B?dXM4OFR3S0dLT0NIdFV3bDJ0ektXZitsSmo3bDVWR1NCc1pERm1mYVArdGVU?=
 =?utf-8?B?TGMrcnNVd1UzYWEwdytSSXVnTFM4NjhQaCszWmhJMVNWcWJCck5jb2oreHdU?=
 =?utf-8?B?bDhkN0pjMEtITnUxZlp4V2F1QmdNSnBSRHh0V0lsSlIwZUkwNUxLd3AxYTg4?=
 =?utf-8?B?ZDl3VFJuMTBXc0Y1S1Fkekk0d0kvUjZETzZiVGQzcGs2b2ZIbmswQUpIdndR?=
 =?utf-8?B?QUh2UnEra2pTcUpkWlpoZ3l2RWJ2Z2JxT0RHM2tvM05PTHVBbWFwU3ppOWtG?=
 =?utf-8?B?Y2RWeXE0OUNIYWpyeXY1anZBbEtQY3dKNUFrNE5KWUFFTC83dUl1RTBiOCs1?=
 =?utf-8?B?ZThSd0ZzbE1nVE1ieFh0WnovclpqNHIzSnRDR1JWcUVnWlA4MHlLcnVrUmNL?=
 =?utf-8?B?SkZkRDNGKzltakZRTlIrTjdURkdwMW9BRSsvMktZOTl5cmgrV0pBSXIrbGRu?=
 =?utf-8?B?WUMxMXVFdjlualVzeHNiTU5xQjZ2MGRacjJwRkd2VEdETUsrWC90NkxOSXk2?=
 =?utf-8?B?QnFnL2drYWluTGF2K1Z3NUxxSm1oeDJMOXBLbjJySFBqcWYwL2VURlBCenNx?=
 =?utf-8?Q?wjA/2Lct/oVQwT+?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb4a0fc-28a7-40ac-f416-08db2bf2a367
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 23:02:12.6011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u03r9zj2mTZvTtyyfjl9VS00CkGvbmP7H5bMpBholA1p/36tvxOVGUSdynNZC3w+31z4LfdB5krfKZ8dCJPXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6327
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTAzLTIzIGF0IDE1OjE0IC0wNzAwLCBKYWVnZXVrIEtpbSB3cm90ZToNCj4g
T24gMDMvMjAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+IE9uIE1vbiwgRmViIDIwLCAy
MDIzIGF0IDAxOjIwOjA0UE0gKzAxMDAsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+ID4gPiBBKSBT
dXBwb3J0aW5nIHByb3BlciBkaXJlY3Qgd3JpdGVzIGZvciB6b25lZCBibG9jayBkZXZpY2VzIHdv
dWxkDQo+ID4gPiBiZSB0aGUgYmVzdCwgYnV0IGl0IGlzIGN1cnJlbnRseSBub3Qgc3VwcG9ydGVk
IChwcm9iYWJseSBmb3INCj4gPiA+IGEgZ29vZCBidXQgbm9uLW9idmlvdXMgcmVhc29uKS4gV291
bGQgaXQgYmUgZmVhc2libGUgdG8NCj4gPiA+IGltcGxlbWVudCBwcm9wZXIgZGlyZWN0IElPPw0K
PiA+IA0KPiA+IEkgZG9uJ3QgdGhpbmsgd2h5IG5vdC7CoCBJbiBtYW55IHdheXMgZGlyZWN0IHdy
aXRlcyB0byB6b25lZCBkZXZpY2VzDQo+ID4gc2hvdWxkIGJlIGVhc2llciB0aGFuIG5vbi1kaXJl
Y3Qgd3JpdGVzLg0KPiA+IA0KPiA+IEFueSBjb21tZW50cyBmcm9tIHRoZSBtYWludGFpbmVycyB3
aHkgdGhlIGRpcmVjdCBJL08gd3JpdGVzIHRvDQo+ID4gem9uZWQNCj4gPiBkZXZpY2VzIGFyZSBk
aXNhYmxlZD/CoCBJIGNvdWxkIG5vdCBmaW5kIGFueXRoaW5nIGhlbHBmdWwgaW4gdGhlDQo+ID4g
Y29tbWVudHMNCj4gPiBvciBjb21taXQgbG9ncy4NCj4gDQo+IFRoZSBkaXJlY3QgSU8gd2FudHMg
dG8gb3ZlcndyaXRlIHRoZSBkYXRhIG9uIHRoZSBzYW1lIGJsb2NrIGFkZHJlc3MsDQo+IHdoaWxl
DQo+IHpvbmVkIGRldmljZSBkb2VzIG5vdCBzdXBwb3J0IGl0Pw0KDQpTdXJlbHkgdGhhdCBpcyBu
b3QgdGhlIGNhc2Ugd2l0aCBMRlMgbW9kZSwgZG9lc24ndCBpdCA/IE90aGVyd2lzZSwgZXZlbg0K
YnVmZmVyZWQgb3ZlcndyaXRlcyB3b3VsZCBoYXZlIGFuIGlzc3VlLg0KDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ACA7328E5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245206AbjFPH3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbjFPH3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:29:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519B1FF7;
        Fri, 16 Jun 2023 00:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW2ZCjVcqrSx0jJJlLLU7fs2bTIcKTmMuywe8sLkT86jEszPKNqzDzBhZ4pyZ4LxhrQ/aG0+27njd9YBuujK1+cz1Nhr6BS1evM7Yv5oPI2EGHDPDQCZaJYANKtkf/5G1pv/M8jJSaj7nxhrKsmCrraqx66Ct8yqy+I6dPDEwHBdTCzRRhlnMvs2aYRQ2f0L1iGC+1Wjlufg7CxlTTH8YQdEsHH2TQffbLgWd3SAGWH17N1R6g5nmx6t92jUxiXSiJB7iwsiB1pi+JAgicxKQjjju6W8M3BNXe4se0PlEyXenJ1oOFmD6siRt3BpGJOFEk3c+VmcFJh9UlT3YXPlYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luM64zW1esd8nyMkAcQ8THDxfES4R30WKA+gJAsMMcI=;
 b=AUbat4JMqQt1TGV8SmQOr/VMdRZmWMLUXRCj6SETZpfkSvW8yZnIGRTVzG1qDH0QYlbK7WFIcAXmni2OKjYB7RM9/rRYURe3UIwQcxq3LkF9WTIHeodSodsiHqzGTggzXZ5RdM5YwpxxCz6NVK7YrRwZghrWDEiAgiSut20he4OF4xeUvWcJQnPT+cecW0/XpzoeSiq808GonCPbOHi+JriH/QLbf/9/lp2tlPuvh9MNFNL02TxxcPwnkxfxGLbdkHBvb9MMs5+AcHOO0SmBpWS4rFkZNlt4SUpEeIyXJ1MEqKqIzUBmn3oJGT1qowkRy4Hg0nyC3cQOiI/GwtP/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luM64zW1esd8nyMkAcQ8THDxfES4R30WKA+gJAsMMcI=;
 b=1hSwE+AkBP3lK4OdE+U86rxzxh+ufuxjKTvQrlmIeLNW1bReCVKFkezxq2YQjPakciT0Wlj1BZPSRgYyju1PNjuNun5LFLygEhIWIckugUpePEA4HaDtV4Ul/j3iym9djP4QlgaPltgTWdTn+HSn3Y51HpaHw3IfloIc+1hNxNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GV1PR08MB9916.eurprd08.prod.outlook.com (2603:10a6:150:a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 07:29:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bd0e:a139:9e67:b86d%4]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 07:29:10 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Fri, 16 Jun 2023 09:28:52 +0200
Subject: [PATCH v3 2/4] dt-bindings: touchscreen: add overlay-touchscreen
 and overlay-buttons properties
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230510-feature-ts_virtobj_patch-v3-2-b4fb7fc4bab7@wolfvision.net>
References: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
In-Reply-To: <20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686900549; l=8153;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=KNTIfSGexgxo0tpiTfZ54RzJDduakcxWEC2nJNHuT4s=;
 b=ltNIhCOlY0PJqO16dKMpSugz7WDUxohG992RsHoBdVKwGna767TwF4PHsB4W/rrEgU+OFPTAU
 aJ/OpiRbkckAu/gvx3+boq6voCh3LQ8bLDWcwPB1y9nCvOnSP77rTGF
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0197.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::21) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GV1PR08MB9916:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bee18e1-eb01-49d8-b904-08db6e3b6049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZvAZ+I2ruoVlLg1Ha1+PWtFBhlIURvB0d6Urq8B3txBIG3Yu8Wrfmcv8OFUZXmVgYBoHYkHO3mNXbneSCDFEY+SRpxqG7uMscr2B6H+2//fGgkSDXkhYS0oInebMvtdIHmFdUBKTpP9f8r0KAgLWCOEYROl4w5xqUES0HmIrdBkFDDq+emVMdVHUlaNmo+PwVBUGvobql70yuywY57eHlxi5lJKP6TdZuVe0yf6I7sNSHU8M591Eo472lrRJuiO09U7VxokUpZcmKlBA/3dOM91LGrdtvhm/SVPbNdC++AaN+028iF0kBWnh0XuvNSZBP/45llbvZMQCNSyXYAJmv5mGoiVI+X1aFRiuGEW+lAcB/2JDnmB6dI+AYgkymszT7ERj6fb4EPn1qgZLuHCXRwos6QgkG34P3jyxhbhJ6ALO7w8mayAgNmpLIxQMdUA4g8ZoKmBeVa3TNjzYhnCR2YuEV5BYP8H4Cxdopb7THWBNfF2UwJBhF/rUc2gFvgP7Y6mFg5XI03aNRO81yU6IiOHJ57Eyx7FKzhZSdRrlF6FQ4FTdYD8ILOU/5n80coJacopTLmdugaddYDnRB75yjtiiui9S1Awcj+67tVUjKDuQ2hFrXbFGmuqlEAZHrr2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(366004)(39850400004)(346002)(451199021)(36756003)(86362001)(2906002)(44832011)(6486002)(6666004)(186003)(52116002)(107886003)(6512007)(6506007)(26005)(6636002)(66476007)(110136005)(316002)(41300700001)(38100700002)(4326008)(66556008)(2616005)(38350700002)(66946007)(5660300002)(478600001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2xKTnoyLzhJbW0wdUhDTkV1RU5mZFBXbUt3QUtFQ0E1NGg2THg2VDUvQkxW?=
 =?utf-8?B?QWxsWVJmcTg5a3NTeW1VNEMrblVodlNuMmNoczUzT2V6cC9vSGVLM1VpSmtK?=
 =?utf-8?B?ZDJXaGdYOTN4dWpZbmpPTXFjT0xpYmp4QVdEcW9yV1B1M2NyZU9oUHpoUzI1?=
 =?utf-8?B?NmljdisyZEtxWnNnT2x6YzcvZ2JVVWx0ZGExTE1WeGFncmV5RnRiY1l1S2hr?=
 =?utf-8?B?ZmJMRVM4VVdTVGRzcS8vaDdrdm1FSjM3aHZkai9LVnFXQ3pCMFJKSUZURmdz?=
 =?utf-8?B?Uml0dnBMRFo5VzhMNUxZaDdHdW9JUlkwdCs2eFZYYytxS1R5MzFKWERpaFZl?=
 =?utf-8?B?UzBXMm5YY0ZJUmtYVk1BVVhLMzQ1cFZDYzFhQXVKTnpZdnNEWWZ5MENpR3dL?=
 =?utf-8?B?c3hvSzdhcmRnb0U2dnh6YkY3VjFHbGN5UEYxK1MvbFVEbGEwZTd0RGJERmxz?=
 =?utf-8?B?Q3hKd2xtRDh1d3N2R2VBcUhSdXIzK0hQWFZMeE1NWGJNcFZqNDBTN0JvQlJM?=
 =?utf-8?B?YktPUUpiOGEzQ3djcVpXemFBVm81aVpndDkrTjVCVUJpVnVzTzV5dklhYnBz?=
 =?utf-8?B?MjB4OG9UcUxlNnJ4QmREbW1vMnd6TnpVY2xmVzB0TFlhZk1tdnhneUFmTnc4?=
 =?utf-8?B?dHJRN2dyZUxCK3EvbmdsRWNHRVFkelV3Q2dJTGd0TllpZ2o1UXllV2xLbjdZ?=
 =?utf-8?B?eFVGT21xZ01xY3JYVW1BdEt6TEplU3AvR3NhSVc4QlZUWjlkeW5RV0F3eTha?=
 =?utf-8?B?S3ZHdkZlVCtjNHBTZVE3ZDVqMWwwMXcyQkl3YVJqcnRpTjlGTFdVS2xYelQ0?=
 =?utf-8?B?OFpMWGxxQ1lMdXhrWXN2UWR4WGsrL3VROXZ1bEtVZHZRbXIrcmpiaWN6U3g3?=
 =?utf-8?B?RmhRSXdvUnpZSVBHUFhqVWhZRHZkbmdiQXhqU3l5UVJXRFVJWStBcDJ4VENX?=
 =?utf-8?B?L3dhb3NQc3F2NU1xYTA5Z3dWMnlVNmhwZU5Edy9SK3htMjNORDZjZzhuZ0Y0?=
 =?utf-8?B?dUZNSFlSNGlqbGkvOFk2WHJZK0UyeWxNaVYzWFBzY2JoSkdSSmt3eEw0WHNN?=
 =?utf-8?B?V2h5SzNXd2dlV1RUSCtKS1NCV094VENUVWdDWVl3aGJrNVdSb3FodE1vWG5p?=
 =?utf-8?B?OWZQVExJVW1odjRxS1QxL1FuU0JsbTl5MlRiMy9ldi9hVWdQR3VWcUthQVlF?=
 =?utf-8?B?Nk10VzBmMFNEQzhvbFlObWRWY1BLYW8yK1ZUZDk4VGt6WVZLTEFKWHN5dXp4?=
 =?utf-8?B?bWFPMGxKQ09vTDdrbjRWMC82eVQyZlNPck0xcUpqOEZUdUtZc2Zxb3ZjcjNu?=
 =?utf-8?B?RUFkbkpxOXZ2RXM1U3p6SWozT3p0eHBUc0Q2elh5NU9zM0tOVWwzbUozZEtI?=
 =?utf-8?B?bUs3ZVdXbW1BUXF0Qlo5WS9GdWVsV2FVQ1lOMmIzSTQ3dzlvMUlhdlhwUHVD?=
 =?utf-8?B?RmUrR2llNkQyQmVWbS9rVFNzejBxdTJveGsxOEhxQUJ3WjBnUmcvUWNYS2dF?=
 =?utf-8?B?QUcyME54UlVPdTlzR0VYUUpmVlNydkhndndzcVk0Z24vUTFvcEdLZ3RaMUtY?=
 =?utf-8?B?ajdaMmErS2w5Nmp1WFNrNVFiOVJMY1F2ZW9yMjVLKzJIOVIxY1c5YWtUK0R5?=
 =?utf-8?B?eE1oL2M3NkJTTWxERjQrTDg1YkMyR1JKTzdkek9jSEp0dEgybjNLNzN2V1A4?=
 =?utf-8?B?ZVpWQzdvNlpQa0tWcW9qbVFaQndnaFlQSzd4T3NkbDlqVXJTQkFtV3RtZzVZ?=
 =?utf-8?B?b1RZTVRmV2xFVUIrZndUaEp3bGIxdEhpb1hsYjEyY2ZGS3FNeVprTXQzZTQv?=
 =?utf-8?B?RXNsVGlCam9Ub21QbG1oaTJ4aHcvMGlkek4xTXZKdi9JeUpIOXJRaVFpdFl0?=
 =?utf-8?B?NlNhTVVudTJ3R09mOXZ3aHRuUFp6NXBVaGJrQXJjVVdTNUxEYUp6QThRdFdt?=
 =?utf-8?B?SzdUcEtiR1o4ZDVKWnRFYUtXUkZyU252MzdpRlRHalVBZURNME5nN1NuMEtp?=
 =?utf-8?B?YjhTWFFoSkx0M0ZSMDBSM2xGZ0psOXVBOVFmWCtOdkxnM0dWRU4rcEwrbHpw?=
 =?utf-8?B?QXlUelRJa1ArME1IV1pRNFBkNm95S0FlYzlhVDQ5aGliMVduUnlIYjNBMXNh?=
 =?utf-8?B?cHlTSXUyc0VSSE5WVVF5cGRkR1l0bm5jZVU3cVpReVVwTVZUZC8zOHB3NUw1?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bee18e1-eb01-49d8-b904-08db6e3b6049
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 07:29:10.2145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3QQ+86gE2p/f+p2e8ci9dm6n5aoN7KdgykY7g5ANs/oVziFWr4/jklFSRq27SAM2ItSF61r8MKUUkRX7/jolAEDqxNFueIBdptN3iJmB85E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB9916
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overlay-touchscreen object defines an area within the touchscreen
where touch events are reported and their coordinates get converted to
the overlay origin. This object avoids getting events from areas that
are physically hidden by overlay frames.

For touchscreens where overlay buttons on the touchscreen surface are
provided, the overlay-buttons object contains a node for every button
and the key event that should be reported when pressed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 .../bindings/input/touchscreen/touchscreen.yaml    | 139 +++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
index 895592da9626..6f5d7ac5560e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
@@ -80,6 +80,145 @@ properties:
   touchscreen-y-plate-ohms:
     description: Resistance of the Y-plate in Ohms
 
+  overlay-touchscreen:
+    description: Clipped touchscreen area
+
+      This object can be used to describe a frame that restricts the area
+      within touch events are reported, ignoring the events that occur outside
+      this area. This is of special interest if the touchscreen is shipped
+      with a physical overlay on top of it with a frame that hides some part
+      of the original touchscreen area.
+
+      The x-origin and y-origin properties of this object define the offset of
+      a new origin from where the touchscreen events are referenced.
+      This offset is applied to the events accordingly. The x-size and y-size
+      properties define the size of the overlay-touchscreen (effective area).
+
+      The following example shows the new touchscreen area and the new origin
+      (0',0') for the touch events generated by the device.
+
+                   Touchscreen (full area)
+         ┌────────────────────────────────────────┐
+         │    ┌───────────────────────────────┐   │
+         │    │                               │   │
+         │    ├ y-size                        │   │
+         │    │                               │   │
+         │    │      overlay-touchscreen      │   │
+         │    │                               │   │
+         │    │                               │   │
+         │    │            x-size             │   │
+         │   ┌└──────────────┴────────────────┘   │
+         │(0',0')                                 │
+        ┌└────────────────────────────────────────┘
+      (0,0)
+
+     where (0',0') = (0+x-origin,0+y-origin)
+
+    type: object
+
+    properties:
+      x-origin:
+        description: horizontal origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-origin:
+        description: vertical origin of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      x-size:
+        description: horizontal resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+      y-size:
+        description: vertical resolution of the clipped area
+        $ref: /schemas/types.yaml#/definitions/uint32
+
+  overlay-buttons:
+    description: list of nodes defining the buttons on the touchscreen
+
+      This object can be used to describe buttons on the touchscreen area,
+      reporting the touch events on their surface as key events instead of
+      the original touch events.
+
+      This is of special interest if the touchscreen is shipped with a
+      physical overlay on top of it where a number of buttons with some
+      predefined functionality are printed. In that case a specific behavior
+      is expected from those buttons instead of raw touch events.
+
+      The overlay-buttons properties define a per-button area as well as an
+      origin relative to the real touchscreen origin. Touch events within the
+      button area are reported as the key event defined in the linux,code
+      property. Given that the key events do not provide coordinates, the
+      button origin is only used to place the button area on the touchscreen
+      surface. Any event outside the overlay-buttons object is reported as a
+      touch event with no coordinate transformation.
+
+      The following example shows a touchscreen with a single button on it
+
+              Touchscreen (full area)
+        ┌───────────────────────────────────┐
+        │                                   │
+        │                                   │
+        │   ┌─────────┐                     │
+        │   │button 0 │                     │
+        │   │KEY_POWER│                     │
+        │   └─────────┘                     │
+        │                                   │
+        │                                   │
+       ┌└───────────────────────────────────┘
+     (0,0)
+
+      The overlay-buttons object can  be combined with the overlay-touchscreen
+      object as shown in the following example. In that case only the events
+      within the overlay-touchscreen object are reported as touch events.
+
+                  Touchscreen (full area)
+        ┌─────────┬──────────────────────────────┐
+        │         │                              │
+        │         │    ┌───────────────────────┐ │
+        │ button 0│    │                       │ │
+        │KEY_POWER│    │                       │ │
+        │         │    │                       │ │
+        ├─────────┤    │  overlay-touchscreen  │ │
+        │         │    │                       │ │
+        │         │    │                       │ │
+        │ button 1│    │                       │ │
+        │ KEY_INFO│   ┌└───────────────────────┘ │
+        │         │(0',0')                       │
+       ┌└─────────┴──────────────────────────────┘
+     (0,0)
+
+    type: object
+
+    patternProperties:
+      '^button-':
+        type: object
+        description:
+          Each button (key) is represented as a sub-node.
+
+        properties:
+          label:
+            $ref: /schemas/types.yaml#/definitions/string
+            description: descriptive name of the button
+
+          linux,code: true
+
+          x-origin:
+            description: horizontal origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-origin:
+            description: vertical origin of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          x-size:
+            description: horizontal resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
+          y-size:
+            description: vertical resolution of the button area
+            $ref: /schemas/types.yaml#/definitions/uint32
+
 dependencies:
   touchscreen-size-x: [ touchscreen-size-y ]
   touchscreen-size-y: [ touchscreen-size-x ]

-- 
2.39.2


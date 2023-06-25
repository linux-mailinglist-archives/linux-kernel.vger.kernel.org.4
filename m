Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8862273D1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjFYPip convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjFYPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:38:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E04FA9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:38:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-87-XSl-NMxtPv-iW-HovudoLw-1; Sun, 25 Jun 2023 16:38:39 +0100
X-MC-Unique: XSl-NMxtPv-iW-HovudoLw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 25 Jun
 2023 16:38:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 25 Jun 2023 16:38:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rishabh Bhatnagar' <risbhat@amazon.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pc@cjr.nz" <pc@cjr.nz>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: RE: [PATCH 5.4 2/5] cifs: Get rid of kstrdup_const()'d paths
Thread-Topic: [PATCH 5.4 2/5] cifs: Get rid of kstrdup_const()'d paths
Thread-Index: AQHZphqs3PWAi6dww0Cq1jX8x+xzU6+bqdcQ
Date:   Sun, 25 Jun 2023 15:38:37 +0000
Message-ID: <043b05d64bca40509bab7dd8e368e4e5@AcuMS.aculab.com>
References: <20230623213406.5596-1-risbhat@amazon.com>
 <20230623213406.5596-3-risbhat@amazon.com>
In-Reply-To: <20230623213406.5596-3-risbhat@amazon.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rishabh Bhatnagar
> Sent: 23 June 2023 22:34
> From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>
> 
> commit 199c6bdfb04b71d88a7765e08285885fbca60df4 upstream.
> 
> The DFS cache API is mostly used with heap allocated strings.
> 
...
> -	ce->path = kstrdup_const(path, GFP_KERNEL);
> +	ce->path = kstrndup(path, strlen(path), GFP_KERNEL);

That is entirely brain-dead.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


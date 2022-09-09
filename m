Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AD65B34CC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIIKGp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIIKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:06:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D908B03
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:06:36 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-135-vA_9hz_UMB--kDxjteYY_w-1; Fri, 09 Sep 2022 11:06:34 +0100
X-MC-Unique: vA_9hz_UMB--kDxjteYY_w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 9 Sep
 2022 11:06:32 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 9 Sep 2022 11:06:32 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'adobriyan@gmail.com'" <adobriyan@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: procfs readlink after unshare() in a chroot() reports the full path
Thread-Topic: procfs readlink after unshare() in a chroot() reports the full
 path
Thread-Index: AdjEMqjMb0GR/+CiSFubzc4Cg1EybA==
Date:   Fri, 9 Sep 2022 10:06:32 +0000
Message-ID: <12add75b103b412494487518c408fe0b@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The readlink calls in procfs (eg for /proc/self/fd/0) returns
the full pathname if unshare() is called inside a chroot.

The program below reproduces this when run with stdin
redirected to a file in the current directory.

This sequence is used by 'ip netns exec' so isn't actually
that unusual.

	David

#define _GNU_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <fcntl.h>
#include <sched.h>

static void print_link(const char *where, int fd)
{
        char buf[256];

        printf("%s: %.*s\n", where, (int)readlinkat(fd, "", buf, sizeof buf), buf);
}

int main(int argc, char **argv)
{
        int link_fd = open("/proc/self/fd/0", O_PATH | O_NOFOLLOW);

        print_link("initial", link_fd);
        if (chroot("."))
                return 1;
        print_link("after chroot", link_fd);
        if (unshare(CLONE_NEWNS))
                return 2;
        print_link("after unshare", link_fd);
        return 0;
}

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


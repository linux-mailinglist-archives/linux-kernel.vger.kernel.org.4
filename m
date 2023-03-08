Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EC6B1040
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCHRf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCHRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772C440C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678296909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uJnoHmMiEQ50Bf/sgKD3h0FbrR1x8YjmBiKx8gh/fG0=;
        b=T9IEcY1IGUZb6oM1IxdSfr4Wo7RhL28xi3jmESy3pBfCdi91nKP6hOBP8YFA3Qyabe5Dvu
        1qsxg0yR5w6Z4mJluvH7u3bekKdx91T6i3akM6vY9UbWRNQnvu8DJ/Tk50po1sEBYB5XNM
        GSuNCzauT2JqJQU936AcZlTPZahgzTw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-H1O2NKkGNSGSNM91jyyYAA-1; Wed, 08 Mar 2023 12:35:08 -0500
X-MC-Unique: H1O2NKkGNSGSNM91jyyYAA-1
Received: by mail-ed1-f72.google.com with SMTP id h15-20020a056402280f00b004bf9e193c23so25222287ede.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296906;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJnoHmMiEQ50Bf/sgKD3h0FbrR1x8YjmBiKx8gh/fG0=;
        b=7KmvZjGqY3xw3Cqjr0DPaRzYi0QJpfU88dVA6P/HX+BgPtsy015tSgZr8u2LULO30e
         zwLAd6N8Iy5mFK+Wrc1Kg7+yL1UbRdlkKprdgl3K38Uz9bekIn+umOSX3ZlmnlDsZ3Y3
         BM2xDqmY0vAcrCDvXtZIyvUA6jSk2Zq7hAk5E8zDg1uVdoVNd3iO0TBaNp6DVrR5zbv5
         Etsrm36zbpc61cAwSucdgzs96Mis7KZU/Siu4XxsLTYAVLBQqy1EADJO7UWPeJYeMjQ/
         SKAfnks4s3V6B/nyAZifzrHXB+71mkVlyYgan+nSGgkpXK0YlR0dR+f3DHzlv9XusWRr
         X7Jw==
X-Gm-Message-State: AO0yUKWuK2XKxtP4eV+mgUU7aaTzitcR3uocKla38X9kapvyeIhcphFq
        Be1iv7YdTHZZnQ8IrhMz6qmKRfmEwzb1yx1bAJ9V8+NZl60rdtL1x37b56i1FmkH7DHRHSAVLBh
        TkGOmH9czTAEB6xDWmOfwBtPqVkHvgOS4LsrDbjMYhc8oOu0BOuolrmZXteazrasKVwEhrw6lDK
        TmlA==
X-Received: by 2002:a17:907:6d92:b0:8ed:e8d6:4e0e with SMTP id sb18-20020a1709076d9200b008ede8d64e0emr27091314ejc.36.1678296906818;
        Wed, 08 Mar 2023 09:35:06 -0800 (PST)
X-Google-Smtp-Source: AK7set9VtDhfK/2yAlK7243teywpjyochmwEoLfe+0nIkV2C59nDi8Jo981NCcIfNQNRXoEABf9fzw==
X-Received: by 2002:a17:907:6d92:b0:8ed:e8d6:4e0e with SMTP id sb18-20020a1709076d9200b008ede8d64e0emr27091280ejc.36.1678296906475;
        Wed, 08 Mar 2023 09:35:06 -0800 (PST)
Received: from redhat.com ([2.52.138.216])
        by smtp.gmail.com with ESMTPSA id g26-20020a17090613da00b008d044ede804sm7624887ejc.163.2023.03.08.09.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:35:06 -0800 (PST)
Date:   Wed, 8 Mar 2023 12:35:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] container_of: add type safety
Message-ID: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a wrong member in container_of will result in an error.
No so for container_of_const - it is just a cast so will
happily give you a wrong pointer.

Use logic from container_of to add safety.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20221205121206.166576-1-gregkh@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/container_of.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/container_of.h b/include/linux/container_of.h
index 1d898f9158b4..5d87faf72e0a 100644
--- a/include/linux/container_of.h
+++ b/include/linux/container_of.h
@@ -29,10 +29,13 @@
  * @type:		the type of the container struct this is embedded in.
  * @member:		the name of the member within the struct.
  */
-#define container_of_const(ptr, type, member)				\
+#define container_of_const(ptr, type, member) ({			\
+	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
+		      __same_type(*(ptr), void),			\
+		      "pointer type mismatch in container_of()");	\
 	_Generic(ptr,							\
 		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
 		default: ((type *)container_of(ptr, type, member))	\
-	)
+	); })
 
 #endif	/* _LINUX_CONTAINER_OF_H */
-- 
MST


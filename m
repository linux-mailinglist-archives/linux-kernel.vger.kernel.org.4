Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1999C617638
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKCFgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKCFgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:36:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320A71109
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:36:20 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d13-20020a17090a3b0d00b00213519dfe4aso861378pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 22:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TkBkjczRfZq8WoQictHOaJZqwEYcHjIcgO1EkCulpQ=;
        b=Ct9g/wbHSd6jH86y5M4rjY+HV8ZYBWZY2MDXcvaIzSU7i8gBMzeEKGFuf1o0TK3Oel
         6EONZBV+w78KynxvAAJXIEmPhGK1xZ4v1kDvd7R4iQts0i+cOh9i/NHSbuB0+2cyifhk
         oOXO0pdRz0JsTYDyZM9KTH03RMUXIY9fVGhCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TkBkjczRfZq8WoQictHOaJZqwEYcHjIcgO1EkCulpQ=;
        b=lMgiYJ2f7po+3ps+6oNct6Bg0np0pgzU9tQdnIwEXbnXUTGUJFh+KmcX4R2RUCgB2o
         VKBakUM579Qmh63Ab1MFmUaXgQ0gIWhmGqpxRH5cYhr/FyPHJO4EDZvF09XvQXsSR5j2
         IxoEcLLnE3DGuiOB64s9GMloNR8NsRROb2LSDUw6oKCTlt6OneL663s/8cerSVujZ+7C
         EvLjlhSLztEQ74WtS/0Vm4NqEcy59eR1+0NQFWpczFGyUpXanp/54pVTI1gZRsTUNMb3
         AfSYnkc7fNNd2Hsnq4o2SfXeZKzkRgaKxBCVBkStry/vUNweB4LSXSILBJ8c58unuihM
         OEqQ==
X-Gm-Message-State: ACrzQf0EvP7KHvwptQYaGUSsAZhfsrns0grQh9in47quymYYNhOzvfAS
        SkgODgSxbssCcBJX7KrahUxsmV9vhqnGVA==
X-Google-Smtp-Source: AMsMyM56yrurEHq7nQ1UTZKYHgdrDmdf/FnazbWByIy3sbseemuEzBNuUV+DrLEXBXixtHA9u90/zw==
X-Received: by 2002:a17:90a:f001:b0:213:bf4:ee29 with SMTP id bt1-20020a17090af00100b002130bf4ee29mr45918167pjb.98.1667453779755;
        Wed, 02 Nov 2022 22:36:19 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:f22:e30:374d:5a2b])
        by smtp.gmail.com with ESMTPSA id n16-20020a635910000000b0046f6d7dcd1dsm8468215pgb.25.2022.11.02.22.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 22:36:19 -0700 (PDT)
Date:   Thu, 3 Nov 2022 14:36:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2NTT4TeB3aT5W+i@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2M/DeLwab0o7btv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2M/DeLwab0o7btv@google.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/03 13:09), Sergey Senozhatsky wrote:
> On (22/11/03 12:05), Sergey Senozhatsky wrote:
> > What is the use case for removal of a secondary algorithm?
> > 
> > > My point is that we don't need to implement it atm but makes the
> > > interface to open the possibility for future extension.
> > > 
> > > What do you think?
> > 
> > So, as far as I understand, we don't have reason to add remove_recomp_algo
> > right now. And existing recomp_algo does not enforce any particular format,
> > it can be extended. Right now we accept "$name" but can do something like
> > "$name:$priority".
> 
> Or with keywords:
> 
> 	name=STRING priority=INT
> 
> and the only legal priority for now is 1.


E.g. recomp_algorithm support for algorithms name= and optional
integer priority=.

I sort of like the recomp_algorithm name so far, but we can change it.

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf9d3474b80c..9a614253de07 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1102,9 +1102,38 @@ static ssize_t recomp_algorithm_store(struct device *dev,
 				      size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	int prio = ZRAM_SECONDARY_ZCOMP;
+	char *args, *param, *val;
+	char *alg = NULL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_SECONDARY_ZCOMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		if (!*val)
+			return -EINVAL;
+
+		if (!strcmp(param, "name")) {
+			alg = val;
+			continue;
+		}
+
+		if (!strcmp(param, "priority")) {
+			ret = kstrtoint(val, 10, &prio);
+			if (ret)
+				return ret;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	if (prio < ZRAM_SECONDARY_ZCOMP || prio >= ZRAM_MAX_ZCOMPS)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, prio, alg);
 	return ret ? ret : len;
 }
 #endif

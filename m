Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F65F27BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 04:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJCC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJCC7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 22:59:24 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C798236DFC
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 19:59:23 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w2so9100049pfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 19:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=W/iKlG/2SK1n0kxoLuiUZGSP3EqDCPf+GU5RrhiJsYQ=;
        b=BoARwX7Nd8WClzBwMyYzJDLffZal0H7oFUVWCp88oQ4skclXYPWsAm5iF/RGz/MyXc
         cdtbif/cuPyeqc79/yPezCzvn1hD0z5ssXRL61Tz5g78eq+I1V3uKREZlYA0HSgpFWIF
         rHVcBz3wnyMTmYZ+AnhVwoG2YUpe0hFZmTVt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=W/iKlG/2SK1n0kxoLuiUZGSP3EqDCPf+GU5RrhiJsYQ=;
        b=vf7L3yq4UMOtjQdYMUi8hC+ast3fbFDSdmHEC001LPaqkvZ2Jb2XkqYI1xgqwL6rIz
         T8X+04+jbLJaXutMCWh8Ke7HAjUTI9yOmWFfSyohPFA9FDh25MVdtf4arKwNYW13rmpl
         QSeh4ZkOIYZePm39V1RdW5UbZuPQ90cUcK1LsIQI/glUC5PJ+nz42EXmOp01Fn9/+aJ4
         c/HLZ+8L5jY263HA/VxSY1UiKxeL9dcx/LA29dYcxRIWYA0zr+h/8GHUqUa+gFC7XYle
         skSI9gVSMXYwOqAa+ludQMQX43cGBttvZ1l93+q8KVpgliUjyB+2k6jyCnlNLytHwepV
         bOSg==
X-Gm-Message-State: ACrzQf2Hb6z/hlLBAwUtqgvm7Fr5u3McJabvOAY7n/+X1YNqeEkjCUIr
        67FsbEPlRI+wXUcGzRVdjxjZtw==
X-Google-Smtp-Source: AMsMyM6QXBFMTaXBeqXDVM8Oc0IYpqgrSmfI3IpOFUyZi2zMU9KE9Pz/Fu2fWk63+AWEA4UJ/eYJlg==
X-Received: by 2002:a63:fa4d:0:b0:43c:7fa:95f7 with SMTP id g13-20020a63fa4d000000b0043c07fa95f7mr16881241pgk.48.1664765963310;
        Sun, 02 Oct 2022 19:59:23 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:fdaf:f7a6:50c8:e952])
        by smtp.gmail.com with ESMTPSA id m12-20020a17090a34cc00b0020a8ed65df3sm1649230pjf.45.2022.10.02.19.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 19:59:22 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:59:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Rom Lemarchand <romlem@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH] zram: Always expose rw_page
Message-ID: <YzpQBqwET9bTEsoU@google.com>
References: <Yy4JkpZ/SnXtrVRf@google.com>
 <20220930195215.2360317-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930195215.2360317-1-bgeffon@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/09/30 15:52), Brian Geffon wrote:
> Currently zram will adjust its fops to a version which does not
> contain rw_page when a backing device has been assigned. This is
> done to prevent upper layers from assuming a synchronous operation
> when a page may have been written back. This forces every operation
> through bio which has overhead associated with bio_alloc/frees.
> 
> The code can be simplified to always expose a rw_page method and
> only in the rare event that a page is written back we instead will
> return -EOPNOTSUPP forcing the upper layer to fallback to bio.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

> @@ -1267,6 +1253,9 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
>  		struct bio_vec bvec;
>  
>  		zram_slot_unlock(zram, index);
> +		/* If we don't have a bio we came via rw_page, we must fallback to bio */
> +		if (!bio)
> +			return -EOPNOTSUPP;

The comment is above 80 cols.

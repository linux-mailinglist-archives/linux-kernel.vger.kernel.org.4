Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117FF67DEEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjA0IRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjA0IQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:16:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B150538B6D
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674807371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wWjslA7V36Tnq5X4Dk1DPZb0FqrAbkUAfwliGUEUMn0=;
        b=h6rf+5U1MF16LbP68kHvps/6dLS5LH6pL+yagMK767szVB/rQWqRYLUfl6Me/GjzKwixPC
        0lR7c+5nKgHbx038K6RgRr7SMHVSyisBaOU6pHQqKx3K+AYfrEIvC0oRWDoSHAPvWj2jiz
        kE2o5lY6z+VV0o7DoTGgdhMwuwBiVXc=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43-4ecd6ZlMN3yazQedcTRZTw-1; Fri, 27 Jan 2023 03:16:08 -0500
X-MC-Unique: 4ecd6ZlMN3yazQedcTRZTw-1
Received: by mail-ua1-f69.google.com with SMTP id y10-20020ab0560a000000b003af33bfa8c4so1585344uaa.21
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWjslA7V36Tnq5X4Dk1DPZb0FqrAbkUAfwliGUEUMn0=;
        b=sYkjB/k/782R3m/9kxC+22/r5Levp1yiftFU3XF8aN5lmjlfqiaQZEA6FjP8dFZHbx
         ICFAAp9mE3hEHqKVOD45G8U/0ouboXbsQ/twC2fTNIwn0EZcEnD/HYlfSlN/u1DZpAG0
         Q8xQQa5WD0RQkBZYaQLf9jWfLQxKa4nmUTIhZIJ+zz8Nybw5MMGTBdhSIEzgBMAEAfHh
         mSgcx/y0rUaejrtf/8MrGrptvR/wcFhydNoBQQP0mfOH8AhPL3hkmIVfnn3JlYkpvkV4
         Xi45pO76lDInf9QhksIzn5yPQGkicW+TKCWpAOIX2zHIkVTzhuwLwXdWWCvX4vELIn3D
         OXUQ==
X-Gm-Message-State: AO0yUKWUBvLYoOb77GXFm0XHGaGLBiGxI9mrDuNPXPD4akhfS//DJtmJ
        CPxaB1092UGiiDjbfyYqnENrcQyR2ifLNTR3UFN6kNcvOTXTF69DXBLCdqFfHRWGprsMqvDI1CE
        Pl1prLht8mLoAUrqD5BDoQqhA
X-Received: by 2002:a67:e195:0:b0:3ce:e81e:323f with SMTP id e21-20020a67e195000000b003cee81e323fmr2643116vsl.18.1674807367945;
        Fri, 27 Jan 2023 00:16:07 -0800 (PST)
X-Google-Smtp-Source: AK7set83wBPz4cZHvtA1Pjgz6tb6cyQS95YMCY1akLKhXcmwLtPZvU+PfA3wqagGAeJWgt5/MrBtFA==
X-Received: by 2002:a67:e195:0:b0:3ce:e81e:323f with SMTP id e21-20020a67e195000000b003cee81e323fmr2643112vsl.18.1674807367727;
        Fri, 27 Jan 2023 00:16:07 -0800 (PST)
Received: from redhat.com ([37.19.199.113])
        by smtp.gmail.com with ESMTPSA id s3-20020a05610201c300b003ef3aba306csm47720vsq.23.2023.01.27.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:16:07 -0800 (PST)
Date:   Fri, 27 Jan 2023 03:16:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] vDPA: initial config export via "vdpa dev show"
Message-ID: <20230127031524-mutt-send-email-mst@kernel.org>
References: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666392237-4042-1-git-send-email-si-wei.liu@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did you say you are going to post v4 of this?
I'm dropping this from review for now.

-- 
MST


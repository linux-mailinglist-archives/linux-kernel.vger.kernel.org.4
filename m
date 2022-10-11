Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF0A5FBBE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiJKUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJKUL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:11:58 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741E95E322;
        Tue, 11 Oct 2022 13:11:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h10so14273040plb.2;
        Tue, 11 Oct 2022 13:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mBCyAW+INIk97qkLgDzPBSuktm9tDmQTnvrDcqdwFdY=;
        b=mI8N8Jym7k6IewpZjJmjwJZD8AJXs6wN+y62IV8nGv+brXyaEn0ZH4blxJxGdbC56s
         PY5q47ZcO1+7p/EWsqqkVVmmfDK6IIMlFFySe8iQ0pZPVn/yJFzyx8D0qIa3E1ZLweyF
         VnD9jngrPuk/s/pqvpGfYlEvRvyxBWSYkjaZTuSC7SjykxUG2b7t9SCVp3u9MtoJHYKs
         k17DMi28DhLi0GxXu9O7Yj/KOnOQo9JRVTAXtDDCZ87Ztyv/vDa1+MYZKwKQSP/FQEMd
         ieSAVju7GPYIxyNe7Q5b07QRKwaQW8BBzyxJlUR7QUTwtdQd2VT5BuV241GtZJvHv1o7
         EO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBCyAW+INIk97qkLgDzPBSuktm9tDmQTnvrDcqdwFdY=;
        b=Z7fXLmJCY30jI5dc5BVo32eqBxw3knYb7P+FDs+NYoHRaL/FeQrUar6YeOXazwAlQ4
         lNbPbM15dm30OR4fjiu6ccBhvfu6ZAFB7YX1BDjUJAwtHxo8w7z5GLPCW0SEM1Ud+9iV
         M5gNQdj+1rEbe2u6NTJde+exukaRNQq1X5mNaNAo3FdubC7DZb/IPyS+z5FVGmix4n9b
         d3IsgRUrpLbQko4EJP0Uab/6NqGFahrlZZHLfGbmWX0y3TaNHtjUdD51fQsvlM1nhhuy
         +JPaaphD9PDoLV/u+Kd/S5kYyJMQPcGhkIIxMBhzVEZ64ejFa76zAskpEVSadkZcjdR5
         kyUQ==
X-Gm-Message-State: ACrzQf0gDUIezLsJm6ziovE0gCW7FM38/p6O5izq3EdZy3gmKVc9HREa
        XQbV5I09NqigeYx8eR15Cco=
X-Google-Smtp-Source: AMsMyM7F1iCyF0evOIhoqF1XoSiOdl4sOwS9KWU2FbBLwXllY8ofMR4g69lCAXCxoF1D1OH28H31Bw==
X-Received: by 2002:a17:902:724a:b0:177:fd96:37bf with SMTP id c10-20020a170902724a00b00177fd9637bfmr24471774pll.25.1665519112138;
        Tue, 11 Oct 2022 13:11:52 -0700 (PDT)
Received: from mail.google.com (122-58-209-93-fibre.sparkbb.co.nz. [122.58.209.93])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902a38600b00178b9c997e5sm9076452pla.138.2022.10.11.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 13:11:50 -0700 (PDT)
Date:   Wed, 12 Oct 2022 09:11:44 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] [next] dlm: replace one-element array with fixed size
 array
Message-ID: <Y0XOAAOLPfj/VHco@mail.google.com>
References: <Y0W5jkiXUkpNl4ap@mail.google.com>
 <Y0XMP2RMkE4MWNPE@mail.google.com>
 <202210111305.743F591@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202210111305.743F591@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:06:32PM -0700, Kees Cook wrote:
> On Wed, Oct 12, 2022 at 09:04:15AM +1300, Paulo Miguel Almeida wrote:
> >  	error = -ENOMEM;
> >  
> > -	ls = kzalloc(sizeof(struct dlm_ls) + namelen, GFP_NOFS);
> > +	ls = kzalloc(sizeof(struct dlm_ls), GFP_NOFS);
>                      ^^^^^^^^^^^^^^^^^^^^
> I think you forgot the suggestion Gustavo had here. :) Preferred style would
> be:
> 	sizeof(*ls)
> 
Ooops, I hadn't seen that one =O 

Alright, v5 in the making

Paulo A.

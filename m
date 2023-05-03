Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E916F601E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjECUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECUfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:35:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5316E95
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 13:35:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-74e3899037cso276584385a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683146101; x=1685738101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnR/TzARCi9ORD4lUtP1KfOau8UkyL+d7OXdq2gatHc=;
        b=aha6EGzh6LnRl4Zmgpp/3IyJWvIpV9yVOp8Omyl1MhLwfx/e+W1fxX6Vcv2GD5+ZTy
         7LZ8/L5OMkUNfVthc0ricTWExpLIOOPY9gq66OHx0COr22kdO/7nru8GXm8CdkkjMJjw
         /GZ7IhLycw5xf2itVJHbKOtuIDkR7wbvZxq1VMJFApEFsdbljt6Ss1fyMxC10uR5UEdP
         e+xtAQHKOPauwg/BjON6D8suLxDF364fypKEwpgWIIF2lwtsAFB1YvosPBuMk0oAHGJW
         aWYNoSLBsVaS3s/1y1wNn1CTJ5HnfZNmPst8Wu72STS4U8wSj6XAy25BNUEuA2duDgV0
         tMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683146101; x=1685738101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnR/TzARCi9ORD4lUtP1KfOau8UkyL+d7OXdq2gatHc=;
        b=Kg8HFJnRdMbQCxeNq+wcYbjIqevoAhYkZAcYm3KGKuc19asE56IiT1RNw3GhKE5Jrd
         Bx4DNo+gI1dBXP1nlmdZB29BTxE2xs+Vt3fvF644EJ9EEmaVtSfPmwiZHKn/c1SfeXD/
         gJ7lEryclbC7ngLwG5XtQE+Mf1mT/6mahn4yDDw6T9vAdhoLjmZj3VkYAhyjSOqIDHgr
         x//7LB+bOoxBP1lZT9ZICxQtKjSz3fNpH+scb2nyM723aoy8cyC9A+MvkMoxT2o7+zSO
         JUYJXMAPEWqEN3CMAqfa4Swzv0b8j2jcAv+4ExYx0wzEFiswi5gv0oP8dA2Za2Bv1dSS
         iU3A==
X-Gm-Message-State: AC+VfDyIhIHU9RE4kpg/G/jZGzFKuqrn57Dqn8RRkg8ipJHnMlTbLZNK
        p+CzysrGI5XkcsTHiwhYvI8=
X-Google-Smtp-Source: ACHHUZ4GeI5C2vuvviOKek4nBNLBtaZ5JuwNPXgbcvT+ICh4R97mtzoOUGzheIiyBUpy+aKmU7i+Ng==
X-Received: by 2002:a05:6214:2689:b0:615:a787:6d4a with SMTP id gm9-20020a056214268900b00615a7876d4amr12207176qvb.27.1683146100943;
        Wed, 03 May 2023 13:35:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c17-20020a0ce151000000b005ef5be4c2f7sm10821690qvl.73.2023.05.03.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 13:35:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 053C627C0054;
        Wed,  3 May 2023 16:34:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 May 2023 16:35:00 -0400
X-ME-Sender: <xms:c8VSZMjsttMxZ-hRgWcuW2vX4Acb2eZYRbdUOL-uvJy5Xla8U_Nf2Q>
    <xme:c8VSZFCd9H2xOLWY_tog7WNRUZ2OtEtOXSJVOYWM_e9vLUkzRIFjXSrXTSXYZ7And
    IJut6lVxj-gRbMorw>
X-ME-Received: <xmr:c8VSZEEzncNzD8akPDadUUnTwH3bAyIT2fJTljXLnJZbHNeURTHvy74Ymdo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:c8VSZNSkymhdKPpgKyfZK8sBP3X-5EJ71cyi2UHbxrWkZiBAMYRN1g>
    <xmx:c8VSZJxqErbErInmov4JD3HvmEDFzBV7VV_nVj8-40zwDWB0pSNt3A>
    <xmx:c8VSZL4oViJ95kLf9tAW7DfrXRD392jBifczyuCK_S7bm_ey7MWZgQ>
    <xmx:c8VSZIwbAB9rXI1RSDV_UftADhNTQQF67qPVSkoGSXA3m2MiCor89g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 16:34:58 -0400 (EDT)
Date:   Wed, 3 May 2023 13:33:54 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang1.zhang@intel.com>
Subject: Re: [RFC PATCH] rcu: rcupdate.h: Add missing parentheses around
 macro pointer dereference
Message-ID: <ZFLFMmGsGF578sg2@boqun-archlinux>
References: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503203236.1587590-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 04:32:36PM -0400, Mathieu Desnoyers wrote:
> linux/rcupdate.h macros use the *p parameter without parentheses, e.g.:
> 
>   typeof(*p)
> 
> rather than
> 
>   typeof(*(p))
> 
> The following test-case shows how it can generate confusion due to C
> operator precedence being reversed compared to the expectations:
> 
>     #define m(p) \
>     do { \
>             __typeof__(*p) v = 0; \
>     } while (0)
> 
>     void fct(unsigned long long *p1)
>     {
>             m(p1 + 1);      /* works */
>             m(1 + p1);      /* broken */
>     }
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang1.zhang@intel.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  include/linux/rcupdate.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index dcd2cf1e8326..1565012fa47f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -430,16 +430,16 @@ static inline void rcu_preempt_sleep_check(void) { }
>  
>  #ifdef __CHECKER__
>  #define rcu_check_sparse(p, space) \
> -	((void)(((typeof(*p) space *)p) == p))
> +	((void)(((typeof(*(p)) space *)p) == p))
>  #else /* #ifdef __CHECKER__ */
>  #define rcu_check_sparse(p, space)
>  #endif /* #else #ifdef __CHECKER__ */
>  
>  #define __unrcu_pointer(p, local)					\
>  ({									\
> -	typeof(*p) *local = (typeof(*p) *__force)(p);			\
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)(p);		\
>  	rcu_check_sparse(p, __rcu);					\
> -	((typeof(*p) __force __kernel *)(local)); 			\
> +	((typeof(*(p)) __force __kernel *)(local));			\
>  })
>  /**
>   * unrcu_pointer - mark a pointer as not being RCU protected
> @@ -452,29 +452,29 @@ static inline void rcu_preempt_sleep_check(void) { }
>  
>  #define __rcu_access_pointer(p, local, space) \
>  ({ \
> -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define __rcu_dereference_check(p, local, c, space) \
>  ({ \
>  	/* Dependency order vs. p above. */ \
> -	typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> +	typeof(*(p)) *local = (typeof(*(p)) *__force)READ_ONCE(p); \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_check() usage"); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define __rcu_dereference_protected(p, local, c, space) \
>  ({ \
>  	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_protected() usage"); \
>  	rcu_check_sparse(p, space); \
> -	((typeof(*p) __force __kernel *)(p)); \
> +	((typeof(*(p)) __force __kernel *)(p)); \
>  })
>  #define __rcu_dereference_raw(p, local) \
>  ({ \
>  	/* Dependency order vs. p above. */ \
>  	typeof(p) local = READ_ONCE(p); \
> -	((typeof(*p) __force __kernel *)(local)); \
> +	((typeof(*(p)) __force __kernel *)(local)); \
>  })
>  #define rcu_dereference_raw(p) __rcu_dereference_raw(p, __UNIQUE_ID(rcu))
>  
> -- 
> 2.25.1
> 
